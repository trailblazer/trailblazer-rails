ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require "trailblazer/rails/test/integration"

Rails.backtrace_cleaner.remove_silencers!
