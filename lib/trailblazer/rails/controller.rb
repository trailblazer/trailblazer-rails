module Trailblazer::Rails
  module Controller
    def run(operation)
      result = operation.(params)

      @form = Trailblazer::Rails::Form.new(result["contract.default"], result["model"].class)
      @model = result["model"]

      yield(result) if result.success? if block_given?
    end

    module Render
      def render(options={}, *args, &block)
        return render_cell(options) if options[:cell]
        super
      end

      def render_cell(options)
        options = options.reverse_merge(layout: true)

        content = options[:cell].(options[:model])

        render( { html: content }.merge(options.except(:model, :cell)) )
      end
    end

    include Render
  end
end
