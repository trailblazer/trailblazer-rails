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

    initializer "trailblazer.load_macros", before: "finisher_hook" do
      [
      # Acti[Trailblazer::Activity::FastTrack,  # DISCUSS: remove?
        Trailblazer::Operation # we need to add this because we're using :adds, so both normalizers get updated.
      ].each do |topology|
        _, _, builder, helpers_module = Trailblazer::Activity::DSL::Topology.build(
          builder: topology.config.builder,
          default_options: {},
          **Trailblazer::Macro::TOPOLOGY_BUILD_OPTIONS # :helpers and :adds
        )

        topology.config.builder = builder
        topology.include helpers_module
      end

      [
      # Acti[Trailblazer::Activity::FastTrack,  # DISCUSS: remove?
        Trailblazer::Operation # we need to add this because we're using :adds, so both normalizers get updated.
      ].each do |topology|
        _, _, builder, helpers_module = Trailblazer::Activity::DSL::Topology.build(
          builder: topology.config.builder,
          default_options: {},
          **Trailblazer::Macro::Contract::TOPOLOGY_BUILD_OPTIONS # :helpers and :adds
        )

        topology.config.builder = builder
        topology.include helpers_module
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
