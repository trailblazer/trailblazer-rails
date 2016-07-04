require 'active_model_helper'
require "test_helper"
require "rails/all"
require "trailblazer/rails"
# require "trailblazer/operation/model/active_model"

class ActiveModelTest < MiniTest::Spec
  Song = Struct.new(:title)

  # contract infers model_name.
  class ContractKnowsModelNameOperation < Trailblazer::Operation
    include Model
    model Song

    contract do
    end
  end

  class NoModelOp < Trailblazer::Operation
    contract do
    end
  end

  it { ContractKnowsModelNameOperation.present(song: {title: "Direct Hit"}).contract.class.model_name.to_s.must_equal "ActiveModelTest::Song" }

  # when Model is not included, contract_class.model= is not called.
  it { NoModelOp.present({}).contract.class.model_name.to_s.must_equal "Reform" }
end
