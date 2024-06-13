require "test_helper"
require 'minitest/capybara'

class SongsControllerTest < Minitest::Capybara::Spec
  it 'can trace' do
    # Capture the standard output
    stdout = StringIO.new
    original_stdout = $stdout
    $stdout = stdout
    Rails.application.config.trailblazer.enable_tracing = true
    visit "/songs/new"
    # Assert that the output contains the expected string
    assert_equal "Song::Operation::New\n|-- \e[32mStart.default\e[0m\n|-- \e[32mmodel.build\e[0m\n|-- \e[32mcontract.build\e[0m\n`-- End.success\n",
      stdout.string

  ensure
    $stdout = original_stdout
    Rails.application.config.trailblazer.enable_tracing = false
  end

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

  it "{#run} accepts runtime variables" do
    visit "/songs/d/songs/create?"
    assert page.has_css? "h1", text: "I'm a form!>>>1>>>>>>" # with "current user" concatenated.
  end

  it "{#run} accepts _run_options variables" do
    visit "/songs/e/songs/create?"
    assert page.has_css? "h1", text: "I'm a form!>>>1>>>>>>" # with "current user" concatenated.
  end

  it "{#run} accepts _run_options variables and runtime variables" do
    visit "/songs/e/songs/patch?"
    assert page.has_css? "h1", text: "I'm a form!>>>1>>>2>>>" # with "current user" and {session} concatenated.
  end

  it "{#run} accepts _run_options variables and run variables and run variables win" do
    visit "/songs/e/songs/put?"
    assert page.has_css? "h1", text: "I'm a form!>>>3>>>2>>>" # with "current user" and {session} concatenated.
  end
end
