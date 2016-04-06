# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'babili/version'

Gem::Specification.new do |spec|
  spec.name          = "babili"
  spec.version       = Babili::VERSION
  spec.authors       = ["Spin42"]
  spec.email         = ["info@spin42.com"]
  spec.summary       = "Babili Ruby Client"
  spec.description   = ""
  spec.homepage      = "https://babili.spin42.me"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client", "1.8.0"
  spec.add_development_dependency "rspec", "3.4.0"
  spec.add_development_dependency "webmock", "1.24.2"
end
