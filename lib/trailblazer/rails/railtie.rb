require "rails/railtie"

module Trailblazer
  class Railtie < ::Rails::Railtie
    config.trailblazer = ActiveSupport::OrderedOptions.new
    ## Accept also an Array of controllers
    config.trailblazer.application_controller ||= %w[ActionController::Base ActionController::API]
    config.trailblazer.enable_tracing ||= false

    initializer "trailblazer.application_controller", before: "finisher_hook" do
      ActiveSupport.on_load(:action_controller) do |app|
        Trailblazer::Railtie.extend_application_controller!(app)
      end
    end

    def extend_application_controller!(app)
      controllers = Array(::Rails.application.config.trailblazer.application_controller).map(&:to_s)
      if controllers.include? app.to_s
        app.send :include, Trailblazer::Rails::Controller
        app.send :include, Trailblazer::Rails::Controller::Cell if defined?(::Cell)
      end
      app
    end
  end
end
