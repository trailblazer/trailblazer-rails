require "test_helper"

class SongOperationTest < Minitest::Spec
  it "what" do
    song = Song.create(title: "Bright Eyes")

    song_count_before = Song.count

  #@ everything runs sweet.
    result = Song::Operation::Upload.(params: {id: song.id}, seq: [])

    assert result.success?
    assert_equal result.to_h.inspect, %{{:params=>{:id=>#{song.id}}, :seq=>[:update_model, :upload, :notify], :model=>#<Song id: #{song.id}, title: "Bright Eyes,updated">}}
    assert_equal Song.count, song_count_before
    assert_equal song.reload.title, %{Bright Eyes,updated}

  #@ breaks in :upload
    result = Song::Operation::Upload.(params: {id: song.id}, seq: [], upload: false)

    assert result.failure?
    assert_equal result.to_h.inspect, %{{:params=>{:id=>#{song.id}}, :seq=>[:update_model, :upload], :upload=>false, :model=>#<Song id: #{song.id}, title: "Bright Eyes,updated,updated">}}
    assert_equal Song.count, song_count_before # no new model was created
    assert_equal song.reload.title, %{Bright Eyes,updated}
  end
end
