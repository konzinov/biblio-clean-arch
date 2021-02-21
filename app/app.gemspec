Gem::Specification.new do |spec|
  spec.name          = 'app'
  spec.version       = '1.0.0'
  spec.authors       = ['Emmanuel Konzi']
  spec.email         = ['maverickkonzinov@gmail.com']

  spec.summary       = 'App'
  spec.description   = 'Module applicatif'
  spec.homepage      = 'https://github.com/konzinov/biblio-clean-arch'
  spec.license       = 'MIT'
  spec.required_ruby_version = ['>= 2.6.0', '<= 2.7.2']
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/konzinov/biblio-clean-arch'

  # Fichiers embarques dans la release de la gem
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
end
