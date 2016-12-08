require "test_helper"

class ArtistsControllerTest < Trailblazer::Test::Integration
  it "cell: Artist::Cell::Dashboard" do
    visit "/artists/dashboard"
    page.must_have_css "h1", visible: "Dashboard"
  end
end
