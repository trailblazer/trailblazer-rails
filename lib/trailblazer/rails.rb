require "trailblazer/rails/version"

module Trailblazer
  module Rails
    # Your code goes here...
  end
end

require "reform/rails"
require "trailblazer/rails/railtie"

require "trailblazer/operation"
# TODO: remove that once i18n, validations etc in Reform/AM are sorted.
Trailblazer::Operation.contract_class.class_eval do
  def self.name
    # for whatever reason, validations climb up the inheritance tree and require _every_ class to have a name (4.1).
    "Reform::Form"
  end
end

# Automatically set model_name on operation's contract when `Op::Model` is included.
require "trailblazer/operation/model"
require "trailblazer/operation/model/active_model"
Trailblazer::Operation::Model::DSL.module_eval do
  include Trailblazer::Operation::Model::ActiveModel # ::contract.
end

require "trailblazer/autoloading"
require "trailblazer/rails/autoloading"
