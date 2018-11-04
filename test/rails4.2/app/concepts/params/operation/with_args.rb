module Params
  class WithArgs < Trailblazer::Operation
    step ->(context, **) { context[:x] = %(#{context[:params].to_h} #{context[:current_user]}) }
  end
end
