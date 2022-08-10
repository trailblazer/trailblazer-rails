require "test_helper"

class CellsControllerTest < Minitest::Capybara::Spec
  it "" do
    visit "/cells/with_layout"
    _(page.body).must_match "<h3>Cell layout</h3><p><h1 theme=\"\">\n  Dashboard\n</h1>\n<a href=\"http://www.example.com/cells/with_layout\">/artists</a>\n</p>\n"

    visit "/cells/without_layout"
    _(page.body[0..9]).must_equal "<h1 theme="

    visit "/cells/with_explicit_layout" # Dark-themed layout set in #render
    _(page.body[0..30]).must_equal "<h3>Dark layout</h3><p><h1 them"
  end

  it "{#cell} can be called without passing {model}" do
    visit "/cells/new"

    assert_equal page.body.chomp, %{<h2>LAYOUT</h2>
<h3>Cell layout</h3><p><p>nil,{:layout=>Artist::Cell::Layout}</p>
</p>
}
  end
end
