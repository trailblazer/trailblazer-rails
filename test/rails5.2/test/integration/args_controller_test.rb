require "test_helper"

class ArgsControllerTest < Minitest::Capybara::Spec
  it "run Song::Create,current_user: Module" do
    visit "/args/with_args"

    page.body.must_match '>{:fake=&gt;&quot;bla&quot;} Module<'
  end
end
