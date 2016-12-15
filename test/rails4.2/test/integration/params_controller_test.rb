require "test_helper"

class ArtistsControllerTest < Trailblazer::Test::Integration
  it "run Song::Create, params, current_user: Module" do
    visit "/params/with_args"
    puts page.body
    page.must_have_css "h1", text: /bla Module/
  end

end
