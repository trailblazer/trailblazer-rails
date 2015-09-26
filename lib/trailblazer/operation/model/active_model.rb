module Trailblazer
  module Operation::Model
    # Automatically set model_name on operation's contract.
    module ActiveModel
      def contract(*, &block)
        super
        contract_class.model(model_class) # this assumes that Form::ActiveModel is mixed in.
      end
    end
  end
end