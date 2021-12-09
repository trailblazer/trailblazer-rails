class Song::Operation::Create < Trailblazer::Operation
  step Subprocess(Song::Operation::New)
  step Contract::Validate()
  step Contract::Persist()
end
