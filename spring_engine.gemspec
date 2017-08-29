# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "spring_engine/version"

Gem::Specification.new do |spec|
  spec.name          = "spring_engine"
  spec.version       = SpringEngine::VERSION
  spec.authors       = ["Ryan Murphy"]
  spec.email         = ["murjax@gmail.com"]

  spec.summary       = %q{Spring configuration gem for Rails engines.}
  spec.description   = %q{spring_engine is a configuration utility for setting up Spring on a Rails engine.}
  spec.homepage      = "https://github.com/murjax/spring_engine"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = "bin"
  spec.executables << 'spring_engine'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "spring"
  spec.add_development_dependency "spring-commands-rspec"
  spec.add_development_dependency "pry"
end
