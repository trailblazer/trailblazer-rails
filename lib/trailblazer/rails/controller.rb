module Trailblazer::Rails
  module Controller
    def run(operation)
      result = operation.(params)

      @form = Trailblazer::Rails::Form.new(result["contract.default"], result["model"].class)
      @model = result["model"]

      yield if result.success? if block_given?
    end
  end
end
