require "test_helper"

class ArgsControllerTest < Minitest::Capybara::Spec
  it "run Song::Create,current_user: Module" do
    visit "/args/with_args"

    _(page.body).must_match ">{:fake=&gt;&quot;bla&quot;} Module<"
    _(page.body).must_match ">my_model<"
    _(page.body).must_match ">my_form<"
  end
end
