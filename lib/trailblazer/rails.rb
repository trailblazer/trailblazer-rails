require "trailblazer/rails/version"

module Trailblazer
  module Rails
    # Your code goes here...
  end
end

# Automatically set model_name on operation's contract when `Op::Model` is included.
require "trailblazer/operation/model"
require "trailblazer/operation/model/active_model"
Trailblazer::Operation::Model::DSL.module_eval do
  include Trailblazer::Operation::Model::ActiveModel # ::contract.
end