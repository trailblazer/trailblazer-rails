class ArtistsController < ApplicationController
  def dashboard
    model = Struct.new(:title).new("Dashboard")
    render cell: Artist::Cell::Dashboard, model: model
  end

  def widget
    model = Struct.new(:title).new("Dashboard")
    render cell: Artist::Cell::Dashboard, model: model, layout: false
  end
end
