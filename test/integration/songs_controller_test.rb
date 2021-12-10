require "test_helper"

class SongsControllerTest < Minitest::Capybara::Spec
  it "new" do
    visit "/songs/new"
    page.has_css? "form.new_song[action='/songs']"
  end

  it "show" do
    song = Song::Operation::Create.call(params: {title: "Skin Trade"})[:model]

    visit "/songs/#{song.id}"
    page.has_css? "h1"
  end

  it "create" do
    visit "/songs/new"
    fill_in "song_title", with: "Out Of My Mind"
    click_button "Create Song"
    page.has_css? "h1"
  end

  it "new_with_result" do
    visit "/songs/new_with_result"
    page.has_css? "h1"
  end

  it "with_variables" do
    visit "/params/with_variables"
    assert_equal %{<h1>"SongsController"</h1>}, page.body
  end
end
