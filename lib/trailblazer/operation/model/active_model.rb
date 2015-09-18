module Trailblazer
  module Operation::Model
    # Set the `::model` on the contract by passing on the operation's model constant.
    module ActiveModel
      def contract(&block)
        super
        contract_class.model(model_class) # this assumes that Form::ActiveModel is mixed in.
      end
    end
  end
end