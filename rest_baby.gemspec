# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rest_baby/version'

Gem::Specification.new do |spec|
  spec.name          = 'rest_baby'
  spec.version       = RestBaby::VERSION
  spec.authors       = ['Dave McNulla']
  spec.email         = ['mcnulla@gmail.com']
  spec.description   = 'Rest client'
  spec.summary       = 'Small rest client developed to testing rest services.'
  spec.homepage      = 'https://github.com/dmcnulla/rest_baby'
  spec.metadata      = { 'ci' => 'https://travis-ci.org/dmcnulla/rest_baby' }
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(/^bin/) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ['lib']

  spec.add_dependency 'nokogiri', '~> 1.6'
  spec.add_dependency 'json', '~> 1.8', '>= 1.8.0'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 0'
  spec.add_development_dependency 'cucumber', '~> 2.1', '>= 2.1.0'
  spec.add_development_dependency 'fig_newton', '~> 0.9'
  spec.add_development_dependency 'rspec', '~> 2.14', '>= 2.14.1'
  spec.add_development_dependency 'webmock', '~> 1.13', '>= 1.13.0'
  spec.add_development_dependency 'yard', '~> 0.8', '>= 0.8.7.6'
  spec.add_development_dependency 'yard-cucumber', '~> 2.3', '>= 2.3.2'
  spec.add_development_dependency 'redcarpet', '~> 3.3', '>= 3.3.0'
end
