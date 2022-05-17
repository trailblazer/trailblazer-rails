require "test_helper"

class ExtractableKeywordsControllerTest < Minitest::Capybara::Spec
  it "extract_one" do
    visit "/extractable_keywords/extract_one"
    assert_equal 'That', page.body
  end

  it "extract_all" do
    visit "/extractable_keywords/extract_all"
    assert_equal 'That worked', page.body
  end
end
