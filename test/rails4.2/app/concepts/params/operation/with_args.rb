module Params
  class WithArgs < Trailblazer::Operation
    step ->(options) { options["x"] = %(#{options["params"]} #{options["current_user"]}) }
  end
end
