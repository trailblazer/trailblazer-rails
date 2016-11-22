class Song::New < Trailblazer::Operation
  extend Contract::DSL

  contract do
    property :id
    property :title
  end

  self.| Model[Song, :create]
  self.| Contract[]
end
