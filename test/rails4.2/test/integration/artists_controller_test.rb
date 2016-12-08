require "test_helper"

class ArtistsControllerTest < Trailblazer::Test::Integration
  it "cell: Artist::Cell::Dashboard" do
    visit "/artists/dashboard"
    page.must_have_css "h1", visible: "Dashboard"
    page.must_have_css "h2", visible: "LAYOUT"
  end

  it "cell: Artist::Cell::Dashboard" do
    visit "/artists/dashboard/widget"
    page.must_have_css "h1", visible: "Dashboard"
    page.wont_have_css "h2", visible: "LAYOUT"
  end
end
