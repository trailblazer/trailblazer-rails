require "rails/railtie"
require "trailblazer/loader"

module Trailblazer
  class Railtie < ::Rails::Railtie
    config.trailblazer = ActiveSupport::OrderedOptions.new
    ## Accept also an Array of controllers
    config.trailblazer.application_controller ||= 'ActionController::Base'
    config.trailblazer.use_loader ||= true

    def self.load_concepts(app)
      # Loader.new.(insert: [ModelFile, before: Loader::AddConceptFiles]) { |file| require_dependency("#{app.root}/#{file}") }
      load_for(app)

      engines.each { |engine| load_for(engine) }
    end

    def self.engines
      if Gem::Version.new(::Rails.version) >= Gem::Version.new("4.1")
        ::Rails.application.railties.find_all { |tie| tie.is_a?(::Rails::Engine) }
      else
        ::Rails.application.railties.engines
      end
    end

    def self.load_for(app)
      Loader.new.(prepend: AllModelFiles, root: app.root) { |file| require_dependency(file) }
    end

    # This is to autoload Operation::Dispatch, etc. I'm simply assuming people find this helpful in Rails.
    initializer "trailblazer.library_autoloading" do
    end

    # thank you, http://stackoverflow.com/a/17573888/465070
    initializer 'trailblazer.install', after: "reform.form_extensions" do |app|
      # the trb autoloading has to be run after initializers have been loaded, so we can tweak inclusion of features in
      # initializers.
      if config.trailblazer.use_loader
        reloader_class.to_prepare do
          Trailblazer::Railtie.load_concepts(app)
        end
      end
    end

    initializer "trailblazer.application_controller", before: "finisher_hook" do
      reloader_class.to_prepare do
        ActiveSupport.on_load(:action_controller) do |app|
          Trailblazer::Railtie.extend_application_controller!(app)
        end
      end
    end

    # Prepend model file, before the concept files like operation.rb get loaded.
    ModelFile = ->(input, options) do
      model = "app/models/#{options[:name]}.rb"
      File.exist?(model) ? [model] + input : input
    end

    # Load all model files before any TRB files.
    AllModelFiles = ->(input, options) do
      Dir.glob("#{options[:root]}/app/models/**/*.rb").sort + input
    end

    private

    def reloader_class
      # Rails 5.0.0.rc1 says:
      # DEPRECATION WARNING: to_prepare is deprecated and will be removed from Rails 5.1
      # (use ActiveSupport::Reloader.to_prepare instead)
      if Gem.loaded_specs['activesupport'].version >= Gem::Version.new('5')
        ActiveSupport::Reloader
      else
        ActionDispatch::Reloader
      end
    end

    module ExtendApplicationController
      def extend_application_controller!(app)
        controllers = Array(::Rails.application.config.trailblazer.application_controller).map { |x| x.to_s }
        if controllers.include? app.to_s
          app.send :include, Trailblazer::Rails::Controller
          app.send :include, Trailblazer::Rails::Controller::Cell if defined?(::Cell)
        end
        app
      end
    end

    extend ExtendApplicationController
  end
end
