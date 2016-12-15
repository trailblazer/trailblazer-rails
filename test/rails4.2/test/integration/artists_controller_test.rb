require "test_helper"

class ArtistsControllerTest < Trailblazer::Test::Integration
  it "cell: Artist::Cell::Dashboard" do
    visit "/artists/dashboard"
    page.must_have_css "h1", visible: "Dashboard"
    page.must_have_css "h2", visible: "LAYOUT"
    page.must_have_css "h1[theme='cute']"
  end

  it "cell: Artist::Cell::Dashboard" do
    visit "/artists/dashboard/widget"
    puts page.body
    page.must_have_css "h1", text: "Dashboard"
    page.wont_have_css "h2", text: "LAYOUT"
  end
end
