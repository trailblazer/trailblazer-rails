require "test_helper"
require "trailblazer/activity/testing"

class SongOperationTest < Minitest::Spec

  it "what" do
    song = Song.create(title: "Bright Eyes")

    song_count_before = Song.count

  #@ everything runs sweet.
    signal, (ctx, _) = Song::Operation::Upload.([{params: {id: song.id}, seq: []}, {}])

    assert_equal signal.to_h[:semantic], :success
    assert_equal ctx.inspect, %{{:params=>{:id=>#{song.id}}, :seq=>[:update_model, :upload, :notify], :model=>#<Song id: #{song.id}, title: "Bright Eyes,updated">}}
    assert_equal Song.count, song_count_before
    assert_equal song.reload.title, %{Bright Eyes,updated}

  #@ breaks in :upload
    signal, (ctx, _) = Song::Operation::Upload.([{params: {id: song.id}, seq: [], upload: false}, {}])

    assert_equal signal.to_h[:semantic], :failure
    assert_equal ctx.inspect, %{{:params=>{:id=>#{song.id}}, :seq=>[:update_model, :upload], :upload=>false, :model=>#<Song id: #{song.id}, title: "Bright Eyes,updated,updated">}}
    assert_equal Song.count, song_count_before # no new model was created
    assert_equal song.reload.title, %{Bright Eyes,updated}
  end
end
