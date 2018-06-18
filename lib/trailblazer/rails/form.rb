module Trailblazer
  class Rails::Form < SimpleDelegator
    def initialize(delegated, model_class)
      super(delegated)
      @model_class = model_class
    end

    def self.name
      # for whatever reason, validations climb up the inheritance tree and require _every_ class to have a name (4.1).
      "Reform::Form"
    end

    def model_name
      if __getobj__.class.model_options
        __getobj__.model_name
      else
        ::ActiveModel::Name.new(self, nil, @model_class.to_s.camelize)
      end
    end

    def to_model
      self
    end
  end
end
