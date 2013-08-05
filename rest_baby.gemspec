# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rest_baby/version'

Gem::Specification.new do |spec|
  spec.name          = "rest_baby"
  spec.version       = RestBaby::VERSION
  spec.authors       = ["Dave McNulla"]
  spec.email         = ["mcnulla@gmail.com"]
  spec.description   = %q{Rest client}
  spec.summary       = %q{This is a small rest client developed for use in testing rest services.}
  spec.homepage      = "https://github.com/dmcnulla/rest_baby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "cucumber", ">= 1.3.5"
  spec.add_development_dependency "fig_newton", ">= 0.9"
  spec.add_development_dependency "json", ">= 1.8.0"
  spec.add_development_dependency "pinch_hitter", ">= 0.3"
  spec.add_development_dependency "rspec", ">= 2.14.1"
  spec.add_development_dependency "webmock", ">= 1.13.0"

end
