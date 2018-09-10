# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bcp47_spec/version'

Gem::Specification.new do |spec|
  spec.name    = 'bcp47_spec'
  spec.version = BCP47::VERSION
  spec.author  = 'Igor Justino'
  spec.license = 'MIT'

  spec.summary  = 'Tasks to help developers manage strings.'
  spec.homepage = 'https://github.com/dadah89/bcp47_spec'

  spec.files = Dir['{lib}/**/*'] + %w[Readme.md]

  spec.add_development_dependency 'bump'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'maxitest'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'single_cov'
end
