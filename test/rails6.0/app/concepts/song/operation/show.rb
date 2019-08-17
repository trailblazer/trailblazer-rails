class Song::Show < Trailblazer::Operation
  step Model(Song, :new)
end
