module Trailblazer::Rails
  module Controller
    def run(operation, params=self.params, *dependencies)
      result = operation.(
        _run_params(params: params),
        *_run_runtime_options(*dependencies)
      )

      model_name, contract_name = Gem::Version.new(::Trailblazer::VERSION) >= Gem::Version.new("2.1") ? [:model, "contract.default"] : ["model", "contract.default"]

      @form  = Trailblazer::Rails::Form.new( result[ contract_name ], result[ model_name ].class )
      @model = result[ model_name ]

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

    module Result
      def result
        @_result
      end
    end

    include Result
  end
end
