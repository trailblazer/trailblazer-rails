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

  def with_expose
    run Song::New
    render cell( Artist::Cell::Show, expose(%w{model contract.default}) )
  end

  def with_expose_and_args
    run Song::New
    render cell( Artist::Cell::Show, expose(%w{model contract.default}, song: @model) )
  end
end
