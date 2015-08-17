# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'metova/webhooks/version'

Gem::Specification.new do |spec|
  spec.name          = "metova-webhooks"
  spec.version       = Metova::Webhooks::VERSION
  spec.authors       = ["Jami Couch"]
  spec.email         = ["jami.couch@metova.com"]

  spec.summary       = "Webhook library for Rails"
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "http://github.com/metova/metova-webhooks"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
