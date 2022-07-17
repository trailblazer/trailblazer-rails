require "test_helper"

class SongsControllerTest < Minitest::Capybara::Spec
  it "new" do
    visit "/songs/new"
    assert page.has_css? "form.new_song[action='/songs']"
  end

  it "show" do
    song = Song::Operation::Create.call(params: {title: "Skin Trade"})[:model]

    visit "/songs/#{song.id}"
    assert page.has_css? "h1"
  end

  it "create" do
    visit "/songs/new"
    fill_in "song_title", with: "Out Of My Mind"
    click_button "Create Song"
    assert page.has_css? "h1"
  end

  it "new_with_result" do
    visit "/songs/new_with_result"
    assert page.has_css? "h1"
  end

  it "with_variables" do
    visit "/params/with_variables"
    assert_equal %{<h1>"SongsController"</h1>}, page.body
  end

  it "{#run} returns result" do
    #@ success
    visit "/songs/a/songs/new?success=true"
    assert page.has_css? "h1", text: "I'm a form!"

    visit "/songs/a/songs/new?"
    assert page.has_css? "h1", text: "I'm a form!"
  end

  it "{#run} returns result and allows block" do
    #@ success
    visit "/songs/a/songs/create?success=true"
    assert_equal page.current_url, "http://www.example.com/songs/1"

    #@ block is not executed, form getting rerendered.
    visit "/songs/a/songs/create?"
    assert page.has_css? "h1", text: "I'm a form!"
  end

  it "{#run} returns result and allows block with kwargs" do
    #@ success
    visit "/songs/c/songs/create?success=true"
    assert_equal page.current_url, "http://www.example.com/songs/1"

    #@ block is not executed, form getting rerendered.
    visit "/songs/c/songs/create?"
    assert page.has_css? "h1", text: "I'm a form!"
  end

  it "you may invoke operations manually" do
    #@ success
    visit "/songs/b/songs/create?success=true"
    assert_equal page.current_url, "http://www.example.com/songs/1"

    #@ block is not executed, form getting rerendered.
    visit "/songs/b/songs/create?"
    assert page.has_css? "h1", text: "I'm a form!"
  end
end
