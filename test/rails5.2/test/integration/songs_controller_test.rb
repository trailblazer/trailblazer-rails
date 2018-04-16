require "test_helper"

class SongsControllerTest < Minitest::Capybara::Spec
  it "new" do
    visit "/songs/new"
    page.must_have_css "form.new_song[action='/songs']"
  end

  it "show" do
    song = Song::Create.(title: "Skin Trade")["model"]

    visit "/songs/#{song.id}"
    page.must_have_css "h1", visible: "Skin Trade"
  end

  it "create" do
    visit "/songs/new"
    fill_in "song_title", with: "Out Of My Mind"
    click_button "Create Song"
    page.must_have_css "h1", visible: "Skin Trade"
  end

  it "new_with_result" do
    visit "/songs/new_with_result"
    page.must_have_css "h1", visible: "Song"
  end
end
