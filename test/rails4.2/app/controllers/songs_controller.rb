class SongsController < ApplicationController
  def new
    result = Song::New.(params)
    @form = Trailblazer::Rails::Form.new(result["contract.default"], result["model.class"])

    @model = result["model"]
  end
end
