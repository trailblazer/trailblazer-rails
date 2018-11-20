require "test_helper"

class ParamsControllerTest < Minitest::Capybara::Spec
  it "run Song::Create, params, current_user: Module" do
    visit "/params/with_args"
    page.body.must_match "{&quot;controller&quot;=&gt;&quot;params&quot;, &quot;action&quot;=&gt;&quot;with_args&quot;} Module"
  end
end
