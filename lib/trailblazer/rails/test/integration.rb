require "minitest/rails/capybara" # loads Capybara, etc.

module Trailblazer::Test
  class Integration < Capybara::Rails::TestCase
  end
end