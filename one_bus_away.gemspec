# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'one_bus_away/version'

Gem::Specification.new do |spec|
  spec.name          = "one_bus_away"
  spec.version       = OneBusAway::VERSION
  spec.authors       = ["Jack Ellis"]
  spec.email         = ["jack@mnmlst.cc"]
  spec.summary       = "Simple Gem to query One Bus Away API"
  spec.description   = "This is a simple gem to query bus stops, delay times, and additional features. This does require that you apply for an API key from One Bus Away -- http://pugetsound.onebusaway.org/p/OneBusAwayApiService.action"
  spec.homepage      = "https://github.com/ellisandy/one-bus-away-cli"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "guard-rspec", "~> 4.5"
  spec.add_dependency('commander')
  spec.add_dependency('rest-client')
end