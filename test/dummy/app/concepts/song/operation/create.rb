class Song::Operation::Create < Trailblazer::Operation
  step Subprocess(Song::Operation::New), id: :new # FIXME:
  step Contract::Validate()
  step Contract::Persist()
end
