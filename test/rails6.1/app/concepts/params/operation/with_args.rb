module Params
  class WithArgs < Trailblazer::Operation
    step ->(context, **) { context[:x] = %{#{context[:params]} #{context[:current_user]}} }
  end
end
