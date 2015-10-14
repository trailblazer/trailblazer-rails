class Trailblazer::Operation
  module Responder
    def errors
      return [] if valid?
      [1]
    end
  end
end