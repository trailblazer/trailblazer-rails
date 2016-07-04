require 'trailblazer/autoloading'

class Concert < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include Model
    include Responder
    model Concert, :create
    contract do
      property :title

      validation do
        required(:title) { filled? }
      end
    end

    def process(params)
      validate(params[:concert]) do
        contract.save
      end
    end
  end
end
