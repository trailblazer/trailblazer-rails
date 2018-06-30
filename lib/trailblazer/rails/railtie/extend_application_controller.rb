require "active_support/concern"

module Trailblazer
  class Railtie < ::Rails::Railtie
    module ExtendApplicationController
      extend ActiveSupport::Concern

      included do
        initializer "trailblazer.application_controller", before: "finisher_hook" do
          reloader_class.to_prepare do
            ActiveSupport.on_load(:action_controller) do |app|
              Trailblazer::Railtie.extend_application_controller!(app)
            end
          end
        end

        def extend_application_controller!(app)
          controllers = Array(::Rails.application.config.trailblazer.application_controller).map { |x| x.to_s }
          if controllers.include? app.to_s
            app.send :include, Trailblazer::Rails::Controller
            app.send :include, Trailblazer::Rails::Controller::Cell if defined?(::Cell)
          end
          app
        end
      end
    end
  end
end
