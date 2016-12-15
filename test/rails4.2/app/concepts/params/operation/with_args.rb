module Params
  class WithArgs < Trailblazer::Operation
    step ->(options) { options["x"] = %{#{options["params"].to_s} #{options["current_user"] }} }
  end
end
