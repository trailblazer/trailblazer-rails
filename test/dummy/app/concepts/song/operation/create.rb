class Song::Operation::New < Trailblazer::Operation
  step Model(Song, :new)
  step Contract::Build(constant: Song::Contract::Create)
end

class Song::Operation::Create < Trailblazer::Operation
  step Subprocess(Song::Operation::New)
  step Contract::Validate()
  step Contract::Persist()
end
