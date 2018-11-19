class ArgsController < ApplicationController
  def with_args
    run Params::WithArgs, fake: "bla"
  end

  private

  def _run_options(options)
    options.merge("current_user" => Module)
  end

  def _assign_trb_ivars(_result)
    super
    @model = "my_model"
  end

  def _wrap_with_trb_form(_form, _model)
    "my_form"
  end
end
