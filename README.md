# Trailblazer::Rails

*Trailblazer in your Rails controllers.*

[![Gitter Chat](https://badges.gitter.im/trailblazer/chat.svg)](https://gitter.im/trailblazer/chat)
[![TRB Newsletter](https://img.shields.io/badge/TRB-newsletter-lightgrey.svg)](http://trailblazer.to/newsletter/)
[![Build
Status](https://travis-ci.org/trailblazer/trailblazer-rails.svg)](https://travis-ci.org/trailblazer/trailblazer-rails)
[![Gem Version](https://badge.fury.io/rb/trailblazer-rails.svg)](http://badge.fury.io/rb/trailblazer-rails)

## Overview

`trailblazer-rails` helps you with the following.

* Running operations in your controller actions.
* Minimalistic integration tests ("smoke tests") to test controller/operation wiring.
* Rendering cells instead of an ActionView in a controller action.

Please refer to the [full documentation for more](http://trailblazer.to/gems/trailblazer/2.0/rails.html).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'trailblazer-rails'
```

Note that the 2.x version only runs with TRB >= 2.1.0.

## Setting flags

* `config.trailblazer.enable_tracing = true` to enable tracing when using `run` (default FALSE)

## Loader 

To use the loader add the trailblazer-loader gem and require 'trailblazer-rails-loader'
```ruby
gem 'trailblazer-loader'
gem 'trailblazer-rails', require: 'trailblazer-rails-loader'
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

