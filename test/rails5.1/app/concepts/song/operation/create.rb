class Song::New < Trailblazer::Operation
  step Model(Song, :new)
  step Contract::Build(constant: Song::Contract)
end

class Song::Create < Trailblazer::Operation
  step Subprocess(Song::New)
  step Contract::Validate()
  step Contract::Persist()
end
