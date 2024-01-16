require "test_helper"
require 'minitest/capybara'

class ArtistsControllerTest < Minitest::Capybara::Spec
  it "cell: Artist::Cell::Dashboard" do
    visit "/artists/dashboard"
    page.has_css? "h1", text: "Dashboard"
    page.has_css? "h2", text: "LAYOUT"
    page.has_css? "h1[theme='cute']"
  end

  it "cell: Artist::Cell::Dashboard" do
    visit "/artists/dashboard/widget"
    page.has_css? "h1", text: "Dashboard"
    page.has_no_css? "h2", text: "LAYOUT"
  end

  #---
  #- expose
  it "expose" do
    visit "/artists/with_expose"
    _(page.body).must_match %{<p>#<Song id: nil, title: nil>,Reform::Form,nil</p>}
  end

  it "expose with additional args" do
    visit "/artists/with_expose_and_args"
    _(page.body).must_match %{<p>#<Song id: nil, title: nil>,Reform::Form,#<Song id: nil, title: nil></p>}
  end
end
