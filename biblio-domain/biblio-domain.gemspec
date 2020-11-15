require_relative 'lib/biblio/domain/version'

Gem::Specification.new do |spec|
  spec.name          = 'biblio-domain'
  spec.version       = Biblio::Domain::VERSION
  spec.authors       = ['Emmanuel Konzi']
  spec.email         = ['maverickkonzinov@gmail.com']

  spec.summary       = 'Write a short summary, because RubyGems requires one.'
  spec.description   = 'Write a longer description or delete this line.'
  spec.homepage      = 'https://github.com/konzinov/biblio-clean-arch'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Specification.new do |s|
    s.required_ruby_version = ['>= 2.6.0', '~> 2.7.0']
  end

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/konzinov/biblio-clean-arch'
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'dry-equalizer'
  spec.add_dependency 'dry-initializer'
end
