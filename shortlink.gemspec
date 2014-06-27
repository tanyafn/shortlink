# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shortlink/version'

Gem::Specification.new do |spec|
  spec.name          = "shortlink"
  spec.version       = Shortlink::VERSION
  spec.authors       = ["Tatyana Fonina"]
  spec.email         = ["tanyafn@gmail.com"]
  spec.summary       = %q{Permalink generator.}
  spec.description   = %q{A simple plugin for creating URL-friendly permalinks (slugs) from attributes.}
  spec.homepage      = "http://github.com/tanyafn/shortlink"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency "sqlite3"
  #spec.add_development_dependency "with_model"

  spec.add_runtime_dependency "activesupport"
  spec.add_runtime_dependency "activerecord", "4.1"
end
