require "active_support/concern"

module Trailblazer
  class Railtie < ::Rails::Railtie
    module Loader
      extend ActiveSupport::Concern

      included do
        def self.load_concepts(app)
          # Loader.new.(insert: [ModelFile, before: Loader::AddConceptFiles]) { |file| require_dependency("#{app.root}/#{file}") }
          load_for(app)

          engines.each { |engine| load_for(engine) }
        end

        def self.engines
          if Gem::Version.new(::Rails.version) >= Gem::Version.new("4.1")
            ::Rails.application.railties.select { |tie| tie.is_a?(::Rails::Engine) }
          else
            ::Rails.application.railties.engines
          end
        end

        def self.load_for(app)
          Trailblazer::Loader.new.(prepend: AllModelFiles, root: app.root) { |file| require_dependency(file) }
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

        # This is to autoload Operation::Dispatch, etc. I'm simply assuming people find this helpful in Rails.
        initializer "trailblazer.library_autoloading" do
        end

        # thank you, http://stackoverflow.com/a/17573888/465070
        initializer "trailblazer.install", after: "reform.form_extensions" do |app|
          # the trb autoloading has to be run after initializers have been loaded, so we can tweak inclusion of features in
          # initializers.
          if config.trailblazer.use_loader
            reloader_class.to_prepare do
              Trailblazer::Railtie.load_concepts(app)
            end
          end
        end
      end
    end
  end
end
