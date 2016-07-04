# controllers
class ApplicationController < ActionController::Base
  append_view_path "test/fake_app/views"
end

class ConcertsController < ApplicationController
  include Trailblazer::Operation::Controller
  respond_to :html

  def create
    respond Concert::Create
  end
end
