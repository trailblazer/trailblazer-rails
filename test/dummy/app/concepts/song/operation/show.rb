class Song::Operation::Show < Trailblazer::Operation
  step Model(Song, :new)
end
