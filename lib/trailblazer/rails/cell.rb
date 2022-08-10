module Trailblazer::Rails::Controller::Cell
  module Render
    def render(cell = nil, options = {}, *, &block)
      return super unless cell.kind_of?(::Cell::ViewModel)

      render_cell(cell, options)
    end

    def render_cell(cell, options)
      options = options.reverse_merge(layout: true)

      # render the cell.
      content = cell.()

      render({html: content}.merge(options))
    end

    def cell(constant, model=nil, options={})
      cell_options = options.reverse_merge(options_for_cell(model, options))

      super(constant, model, cell_options) # From cells-rails gem.
    end

    # Override this to customize what options are passed into the cell constructor.
    # E.g. `{layout: Song::Cell::Layout}`
    def options_for_cell(_model, _options)
      {}
    end
  end

  include Render unless method_defined?(:render_cell) # FIXME: this will be removed soon.
end
