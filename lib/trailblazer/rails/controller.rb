module Trailblazer::Rails
  module Controller
    def run(operation, params=self.params, *dependencies)
      result = operation.(
        _run_params(params),
        *_run_runtime_options(*dependencies)
      )

      _assign_trb_ivars(result)

      yield(result) if result.success? && block_given?

      @_result = result
    end

  private
    # Override to tweak params. Not recommended.
    # Use a deserializer instead.
    def _run_params(params)
      params
    end

    # This is where we can inject Dry.RB containers and the like via dependencies.
    def _run_runtime_options(options={}, *dependencies)
      [_run_options(options), *dependencies]
    end

    # Override this to inject dependencies such as "current_user"
    # into the runtime options.
    def _run_options(options)
      options
    end

    def _assign_trb_ivars(result)
      @model = result["model"]
      @form  = _wrap_with_trb_form(result["contract.default"], @model.class)
    end

    def _wrap_with_trb_form(form, model)
      Trailblazer::Rails::Form.new(form, model)
    end

    module Result
      def result
        @_result
      end
    end

    include Result
  end
end
