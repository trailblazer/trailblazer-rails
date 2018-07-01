ENV["RAILS_ENV"] = "test"
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'

require "trailblazer/rails/test/integration"
