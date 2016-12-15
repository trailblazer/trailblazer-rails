module Params
  class WithArgs < Trailblazer::Operation
    step ->(options) { options["x"] = %{#{options["params"][:fake]} #{options["current_user"] }} }
  end
end
