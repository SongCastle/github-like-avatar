require 'pathname'
require_relative 'test_helper'

describe GitHubLikeAvatar do
  describe '.generate' do
    subject { GitHubLikeAvatar.generate(*args) }

    it 'yield a generated avatar\'s path' do
      _path = nil

      ret = GitHubLikeAvatar.generate('a.png') do |path|
        expect(path).must_be_kind_of(String)
        expect(path.end_with?('a.png')).must_equal(true)
        expect(File.exist?(path)).must_equal(true)

        image = Vips::Image.new_from_file(path)
        expect(image.width).must_equal(150)
        expect(image.height).must_equal(150)

        _path = path

        'something...'
      end

      expect(ret).must_equal('something...')
      expect(Pathname(_path).dirname.exist?).must_equal(false)
    end

    describe 'with a blocks option' do
      it 'yield a generated avatar\'s path with the specified size (blocks)' do
        GitHubLikeAvatar.generate('a.png', blocks: 10) do |path|
          expect(path).must_be_kind_of(String)
          expect(File.exist?(path)).must_equal(true)

          image = Vips::Image.new_from_file(path)
          expect(image.width).must_equal(300)
          expect(image.height).must_equal(300)
        end
      end
    end

    describe 'with a block_size option' do
      it 'yield a generated avatar\'s path with the specified size (block_size)' do
        GitHubLikeAvatar.generate('a.png', block_size: 20) do |path|
          expect(path).must_be_kind_of(String)
          expect(File.exist?(path)).must_equal(true)

          image = Vips::Image.new_from_file(path)
          expect(image.width).must_equal(100)
          expect(image.height).must_equal(100)
        end
      end
    end

    describe 'without block' do
      it 'return a generated avatar\'s path' do
        path = GitHubLikeAvatar.generate('a.png')

        expect(path).must_be_kind_of(String)
        expect(path.end_with?('a.png')).must_equal(true)
        expect(File.exist?(path)).must_equal(true)

        image = Vips::Image.new_from_file(path)
        expect(image.width).must_equal(150)
        expect(image.height).must_equal(150)

        FileUtils.rm_r(Pathname(path).dirname, :secure => true)
      end
    end
  end
end
