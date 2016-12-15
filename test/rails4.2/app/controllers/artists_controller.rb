class ArtistsController < ApplicationController
  def dashboard
    model = Struct.new(:title).new("Dashboard")
    render cell( Artist::Cell::Dashboard, model, theme: "cute" )
  end

  def widget
    model = Struct.new(:title).new("Dashboard")
    render cell( Artist::Cell::Dashboard, model ), layout: false
  end

  include Trailblazer::Rails::Controller::Expose
  def new
    run Song::New
    render cell( Artist::Cell::Show, expose(%w{model contract.default}) )
  end
end
