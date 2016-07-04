if defined?(Dry)
require 'test_helper.rb'

ActionController::TestCase.class_eval do
  setup do
    @routes = Rails.application.routes
  end
end

class GenericResponderTest < ActionController::TestCase
  tests ConcertsController

  setup do
    @routes = Rails.application.routes
  end

  test "Create with params" do
    post :create, {concert: {title: "Ramones at CBGB"}}
    assert_response 302

    concert = Concert.last
    assert_equal "Ramones at CBGB", concert.title
  end
end
end
