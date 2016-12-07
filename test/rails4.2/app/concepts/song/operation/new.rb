class Song::New < Trailblazer::Operation
  extend Contract::DSL

  contract do
    property :id
    property :title
  end

  step Model( Song, :create )
  step Contract::Build()
end
