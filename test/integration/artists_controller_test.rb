require "test_helper"

class ArtistsControllerTest < Minitest::Capybara::Spec
  it "cell: Artist::Cell::Dashboard" do
    visit "/artists/dashboard"
    page.must_have_css "h1"
    page.must_have_css "h2"
    page.must_have_css "h1[theme='cute']"
  end

  it "cell: Artist::Cell::Dashboard" do
    visit "/artists/dashboard/widget"
    page.must_have_css "h1"
    page.wont_have_css "h2"
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
