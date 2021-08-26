require "test_helper"

class CellsControllerTest < Minitest::Capybara::Spec
  it "" do
    visit "/cells/with_layout"

    _(page.body).must_match "<h2>LAYOUT</h2>\n<h1 theme=\"\">\n  Dashboard\n</h1>\n<a href=\"http://www.example.com/cells/with_layout\">/artists</a>"
    # _(page.body).must_match ">my_model<"
    # _(page.body).must_match ">my_form<"

    visit "/cells/with_explicit_layout"

    _(page.body[0..9]).must_equal "<h1 theme="

  end
end
