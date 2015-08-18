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
  spec.description   = spec.summary
  spec.homepage      = "http://github.com/metova/metova-webhooks"
  spec.license       = "MIT"

  spec.files         = Dir["{app,config,db,lib}/**/*", "LICENSE.txt", "Rakefile", "README.md"]

  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency 'rails', '~> 4.2.0'
  spec.add_dependency 'responders', '~> 2.0'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'combustion', '~> 0.5.3'
  spec.add_development_dependency 'shoulda'
  spec.add_development_dependency 'shoulda-matchers', '~> 2.8.0'
end
