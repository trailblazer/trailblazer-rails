class ParamsController < ApplicationController
  def with_args
    run Params::WithArgs, { fake: "bla" }, "current_user" => Module
  end
end
