module Trailblazer::Rails
  module Controller
    # TODO: deprecate {*dependencies}.
    def run_v21(operation, *dependencies, **variables, &block)
      result = if Rails.application.config.trailblazer.enable_tracing
                 _run_operation_v21(operation, :wtf?, *dependencies, **variables)
               else
                 _run_operation_v21(operation, :call, *dependencies, **variables)
               end

      _assign_trb_ivars(result)

      @_result = result

      return result if result.failure? || block.nil?

      if block.arity.eql?(1)
        yield(result)
      else
        yield(result, **result.to_hash)
      end

      result
    end

    alias run run_v21 unless method_defined?(:run)

    private

    # Override to tweak params. Not recommended.
    # Use a deserializer instead.
    def _run_params(run_params)
      run_params
    end

    # This is where we can inject Dry.RB containers and the like via dependencies.
    def _run_runtime_options(ctx = {}, *dependencies)
      [_run_options(ctx), *dependencies]
    end

    # Override this to inject dependencies such as "current_user"
    # into the runtime options.
    def _run_options(ctx)
      ctx
    end

    def _run_operation_v21(operation, call_method, *dependencies, **variables)
      operation.public_send(
        call_method,
        {params: _run_params(params.dup)}.
        merge(*_run_runtime_options(*dependencies)).
        merge(variables)
      )
    end

    def _assign_trb_ivars(result)
      @model = result[:model]
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
