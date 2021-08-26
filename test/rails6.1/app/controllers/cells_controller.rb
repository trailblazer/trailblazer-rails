class CellsController < ApplicationController
  def with_layout
    model = Struct.new(:title).new("Dashboard")
    render cell(Artist::Cell::Dashboard, model)
  end

  def with_explicit_layout
    model = Struct.new(:title).new("Dashboard")
    render cell(Artist::Cell::Dashboard, model), layout: false
  end

  private def options_for_render_cell(options)
    {
      layout: Artist::Cell::Layout
    }
  end
end
