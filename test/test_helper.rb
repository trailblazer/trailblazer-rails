ENV["RAILS_ENV"] ||= "test"
require File.expand_path("dummy/config/environment", __dir__)
require "rails/test_help"

# require "trailblazer/rails/test/integration"
require "minitest/autorun"
require "capybara/rails"

Rails.backtrace_cleaner.remove_silencers!
