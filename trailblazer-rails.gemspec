require_relative "lib/trailblazer/rails/version"

Gem::Specification.new do |spec|
  spec.name          = "trailblazer-rails"
  spec.version       = Trailblazer::Rails::VERSION
  spec.authors       = ["Nick Sutterer"]
  spec.email         = ["apotonick@gmail.com"]

  spec.summary       = "Convenient Rails support for Trailblazer."
  spec.homepage      = "https://trailblazer.to/2.1/docs/trailblazer.html#trailblazer-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "railties", ">= 6.0.0"
  spec.add_dependency "trailblazer", ">= 2.1.0", "< 2.2.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "capybara"
end
