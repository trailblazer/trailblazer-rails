# Trailblazer::Rails

*Trailblazer in your Rails controllers.*

[![TRB Newsletter](https://img.shields.io/badge/TRB-newsletter-lightgrey.svg)](http://trailblazer.to/newsletter/)
![Build
Status](https://github.com/trailblazer/trailblazer-rails/actions/workflows/ci.yml/badge.svg?branch=master)
[![Gem Version](https://badge.fury.io/rb/trailblazer-rails.svg)](http://badge.fury.io/rb/trailblazer-rails)

## Endpoint

This gem is slowly being superseded by TRB's [`endpoint` gem](https://trailblazer.to/2.1/docs/endpoint.html). Endpoints are "controller operations" that invoke your business logic operation. They are much easier to use and customize and are explained in part II of the [BUILDALIB book](https://leanpub.com/buildalib).

## Overview

`trailblazer-rails` helps you with the following.

* Running operations in your controller actions.
* Minimalistic integration tests ("smoke tests") to test controller/operation wiring.
* Rendering cells instead of an ActionView in a controller action.

Please refer to the [full documentation for more](https://trailblazer.to/2.1/docs/trailblazer.html#trailblazer-rails).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'trailblazer-rails'
```

Note that the 2.x version only runs with TRB >= 2.1.0.

## Setting flags

Before `trailblazer-rails` 2.3.0 you could activate or disable the `trailblazer-loader` gem. In versions >= 2.3.0 this component has been removed in favor of Rails autoloading.

* `config.trailblazer.enable_loader = false` to disable Trailblazer loader (default TRUE)
* `config.trailblazer.enable_tracing = true` to enable tracing when using `run` (default FALSE)

## Testing

If you feel like contributing, you can run the test suite per Rails version as follows.

```
$ BUNDLE_GEMFILE=gemfiles/rails_7.0.gemfile bundle exec rake db:create db:schema:load test
```

Successful merges will be rewarded with at least one beer!

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

