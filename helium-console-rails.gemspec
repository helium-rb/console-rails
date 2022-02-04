# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'helium/console/rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'helium-console-rails'
  spec.version       = Helium::Console::Rails::VERSION
  spec.authors       = ['Stanislaw Klajn']
  spec.email         = ['sklajn@gmail.com']

  spec.summary       = 'Formatting for rails objects'
  spec.homepage      = 'https://github.com/helium-rb/console-rails'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/helium-rb/console-rails'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'helium-console', '~> 0.1.12'
  spec.add_dependency 'pry-rails', '~> 0.3.9'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
