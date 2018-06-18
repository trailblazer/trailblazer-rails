require "rails/railtie"
require "trailblazer/loader"
require "trailblazer/rails/railtie/loader"
require "trailblazer/rails/railtie/extend_application_controller"

module Trailblazer
  class Railtie < ::Rails::Railtie
    config.trailblazer = ActiveSupport::OrderedOptions.new
    ## Accept also an Array of controllers
    config.trailblazer.application_controller ||= "ActionController::Base"
    config.trailblazer.use_loader ||= true

    include Loader
    include ExtendApplicationController

    private

    def reloader_class
      # Rails 5.0.0.rc1 says:
      # DEPRECATION WARNING: to_prepare is deprecated and will be removed from Rails 5.1
      # (use ActiveSupport::Reloader.to_prepare instead)
      if Gem.loaded_specs["activesupport"].version >= Gem::Version.new("5")
        ActiveSupport::Reloader
      else
        ActionDispatch::Reloader
      end
    end
  end
end
