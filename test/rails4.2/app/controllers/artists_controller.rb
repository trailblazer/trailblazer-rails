class ArtistsController < ApplicationController
  def dashboard
    model = Struct.new(:title).new("Dashboard")
    render cell( Artist::Cell::Dashboard, model, theme: "cute" )
  end

  def widget
    model = Struct.new(:title).new("Dashboard")
    render cell( Artist::Cell::Dashboard, model ), layout: false
  end
end
