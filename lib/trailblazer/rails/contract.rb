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
      ::ActiveModel::Name.new(self, nil, @model_class.to_s.camelize)
    end

    def to_model
      self
    end
  end
end
