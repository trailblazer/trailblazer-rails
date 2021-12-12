require "rails/railtie"
require "trailblazer/rails/railtie/extend_application_controller"
require "trailblazer/rails/railtie/loader"

module Trailblazer
  class Railtie < ::Rails::Railtie
    config.trailblazer = ActiveSupport::OrderedOptions.new
    ## Accept also an Array of controllers
    config.trailblazer.application_controller ||= "ActionController::Base"
    config.trailblazer.enable_loader ||= true
    config.trailblazer.enable_tracing ||= false

    include Loader
    include ExtendApplicationController
  end
end
