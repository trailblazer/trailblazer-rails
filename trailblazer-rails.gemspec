lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trailblazer/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "trailblazer-rails"
  spec.version       = Trailblazer::Rails::VERSION
  spec.authors       = ["Nick Sutterer"]
  spec.email         = ["apotonick@gmail.com"]

  spec.summary       = %q{Convenient Rails support for Trailblazer.}
  spec.homepage      = "http://trailblazer.to/gems/trailblazer/2.0/rails.html"
  spec.license       = "LGPL-3.0"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "trailblazer", ">= 2.1.0.beta1", "< 2.2.0"
  spec.add_dependency "trailblazer-loader", ">= 0.1.0"
  spec.add_dependency "reform-rails", ">= 0.1.4", "< 0.2.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rubocop"
end
