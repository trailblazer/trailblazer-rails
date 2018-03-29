ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# require "trailblazer/rails/test/integration"
require "minitest/autorun"
require "capybara/rails"

Rails.backtrace_cleaner.remove_silencers!
