# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'postcodes_io/version'

Gem::Specification.new do |spec|
  spec.name          = "postcodes_io"
  spec.version       = Postcodes::VERSION
  spec.authors       = ["James Ruston"]
  spec.email         = ["jruston90@gmail.com"]
  spec.summary       = %q{Lookup postcodes}
  spec.description   = %q{Get rich data from postcode lookups. Wraps postcodes.io}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"

  spec.add_runtime_dependency "excon", "~> 0.39"
end
