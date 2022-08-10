class CellsController < ApplicationController
  def with_layout
    model = Struct.new(:title).new("Dashboard")
    render cell(Artist::Cell::Dashboard, model), layout: false
  end

  def without_layout
    model = Struct.new(:title).new("Dashboard")
    render cell(Artist::Cell::Dashboard, model, layout: false), layout: false # FIXME: this still renders the cell's layout.
  end

  # override controller-wide layout in {#cell}.
  def with_explicit_layout
    model = Struct.new(:title).new("Dashboard")
    render cell(Artist::Cell::Dashboard, model, layout: Artist::Cell::DarkLayout), layout: false
  end

  #@ model-less, model can be skipped.
  def new
    render cell(Artist::Cell::New)
  end

  private

  def options_for_cell(_model, _options)
    {
      layout: Artist::Cell::Layout
    }
  end
end
