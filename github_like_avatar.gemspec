lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'github_like_avatar/version'

Gem::Specification.new do |s|
  s.name        = 'github_like_avatar'
  s.version     = GitHubLikeAvatar::VERSION
  s.platform    = Gem::Platform::RUBY
  s.licenses    = 'MIT'
  s.summary     = 'GitHub like avatar generator'
  s.email       = '-'
  s.homepage    = 'https://github.com/SongCastle/github_like_avatar'
  s.description = 'GitHub like avatar generator.'
  s.authors     = ['-']

  s.files                 = Dir['lib/**/*', 'README.md']
  s.require_paths         = ['lib']
  s.required_ruby_version = Gem::Requirement.new('>= 2.0.0')

  s.add_dependency('ruby-vips', '>= 2.0.0')
end
