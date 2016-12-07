require "test_helper"

class SongsControllerTest < Trailblazer::Test::Integration
  it "new" do
    visit "/songs/new"
    page.must_have_css "form.new_song[action='/songs']"
  end
end
