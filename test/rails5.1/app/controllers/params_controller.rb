class ParamsController < ApplicationController
  def with_args
    run Params::WithArgs
    render "args/with_args"
  end

private
  def _run_options(options)
    options.merge(:current_user => Module )
  end
end
