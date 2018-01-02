class ArgsController < ApplicationController
  def with_args
    run Params::WithArgs, { fake: "bla" }
  end

  def _run_options(context)
    context.merge({ :current_user => Module })
  end
end
