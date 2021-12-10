class Song::Operation::New < Trailblazer::Operation
  step Model(Song, :new)
  step Contract::Build(constant: Song::Contract::Create)
end
