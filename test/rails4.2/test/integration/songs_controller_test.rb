require "test_helper"

class SongsControllerTest < ActionDispatch::IntegrationTest
  test "new" do
    get "/songs/new"
  end
end
