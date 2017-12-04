module Params
  class WithArgs < Trailblazer::Operation
    step ->(options) { options["x"] = %{#{options["params"].to_h} #{options["current_user"] }} }
  end
end
