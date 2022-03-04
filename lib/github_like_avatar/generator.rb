#
# Generate a random avatar like GitHub.
#
# Rewite below Node package for Ruby.
# @see https://github.com/vvanghelue/github-like-avatar-generator
#
# ruby-vips required.
#

require 'tmpdir'
require 'ruby-vips'

module GitHubLikeAvatar
  class InvalidFileName  < ArgumentError; end
  class InvalidBlocks    < ArgumentError; end
  class InvalidBlockSize < ArgumentError; end

  DEFAULT_BLOCKS = 5
  DEFAULT_BLOCK_SIZE = 30

  class << self
    #
    # Generate a random avatar like GitHub.
    # @param filename [String] File name
    # @option blocks [Integer] Number of vertical/horizontal blocks
    # @option block_size [Integer] Pixels per block
    #
    # ```
    # # e.g.
    # GitHubLikeAvatar.generate('avatar.png', blocks: 5, block_size: 20) do |path|
    #   # something like ...
    #   # FileUtils.cp(path, <dest_path>)
    # end
    # ```
    #
    def generate(filename, blocks: DEFAULT_BLOCKS, block_size: DEFAULT_BLOCK_SIZE)
      raise InvalidFileName  unless filename.is_a?(String)
      raise InvalidBlocks    unless blocks.is_a?(Integer) && blocks > 0
      raise InvalidBlockSize unless block_size.is_a?(Integer) && block_size > 0

      too_small, half_blocks = blocks <= 2, blocks / 2.0
      half_c_blocks = half_blocks.ceil
  
      dominant_color, dominant_color2 = rand * 256, rand * 256

      color_func = -> n do
        random_color(
          ((half_blocks <= n) || (n == 0) && !too_small),
          (rand > 0.9 ? dominant_color : dominant_color2)
        )
      end
      blankable_color = Proc.new { random_color }

      image =
        half_c_blocks.times.inject(nil) do |i|
          col =
            blocks.times.inject(nil) do |j, n|
              piece = Vips::Image.black(block_size, block_size) + color_func.(n)
              j ? j.join(piece, :vertical) : piece
            end
          color_func = blankable_color
          i ? col.join(i, :horizontal) : col
        end

      if blocks > 1
        flipped_image = image.flip(:horizontal)
        if blocks.odd?
          flipped_image = flipped_image.extract_area(
            block_size, 0, (blocks - half_c_blocks) * block_size, blocks * block_size
          )
        end
        image = image.join(flipped_image, :horizontal)
      end

      write_avatar = -> dir do
        File.join(dir, filename).tap do |path|
          image.write_to_file(path)
        end
      end

      return write_avatar.(Dir.mktmpdir) unless block_given?

      Dir.mktmpdir do |tmp_dir|
        avatar_path = write_avatar.(tmp_dir)
        yield avatar_path
      end
    end

    private

    def random_color(can_be_blank=true, dominant_color=nil)
      return Array.new(3, (255 * 'AA'.hex / 255.0).floor) if (can_be_blank && rand < 0.3)

      if dominant_color
        delta = rand * 60 - 30
        color_value = (dominant_color + delta).floor
        color_value = [[color_value, 256].min, 0].max
      else
        color_value = (rand * 256).floor
      end

      hsl_to_rgb(color_value, 100, 80)
    end

    def hsl_to_rgb(h, s, l)
      h = 0 if h == 360
      l2 = l < 50 ? l : 100 - l
      s2 = s / 100.0

      max = (l + l2 * s2) * 2.55
      min = (l - l2 * s2) * 2.55

      f = -> x { (max - min) * x / 60.0 + min }

      r, g, b =
        if h <= 60
          [max, f.(h), min]
        elsif h <= 120
          [f.(120 - h), max, min]
        elsif h <= 180
          [min, max, f.(h - 120)]
        elsif h <= 240
          [min, f.(240 - h), max]
        elsif h <= 300
          [f.(h - 240), min, max]
        else
          [max, min, f.(360 - h)]
        end

      [r.round, g.round, b.round]
    end
  end
end
