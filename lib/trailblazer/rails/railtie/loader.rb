require "active_support/concern"

module Trailblazer
  class Railtie < ::Rails::Railtie
    module Loader
      extend ActiveSupport::Concern

      included do # rubocop:disable Metrics/BlockLength
        def self.load_concepts(app)
          load_for(app)

          engines.each { |engine| load_for(engine) }
        end

        def self.engines
          ::Rails.application.railties.select { |tie| tie.is_a?(::Rails::Engine) }
        end

        def self.load_for(app)
          Trailblazer::Loader.new.(prepend: AllModelFiles, root: app.root) { |file| require_dependency(file) }
        end

        # Prepend model file, before the concept files like operation.rb get loaded.
        ModelFile = lambda do |input, options|
          model = "app/models/#{options[:name]}.rb"
          File.exist?(model) ? [model] + input : input
        end

        # Load all model files before any TRB files.
        AllModelFiles = lambda do |input, options|
          Dir.glob("#{options[:root]}/app/models/**/*.rb").sort + input
        end

        # This is to autoload Operation::Dispatch, etc. I'm simply assuming people find this helpful in Rails.
        initializer "trailblazer.library_autoloading" do
        end

        # thank you, http://stackoverflow.com/a/17573888/465070
        initializer "trailblazer.install", after: "reform.form_extensions" do |app|
          # the trb autoloading has to be run after initializers have been loaded, so we can tweak inclusion of features in
          # initializers.

          # TODO: remove me in the next version!
          if config.trailblazer.use_loader.to_s.present?
            warn "DEPRECATION WARNING [trailblazer-rails]: please use config.trailblazer.enable_loader" \
                 " to enable/disable the loader. config.trailblazer.use_loader will be removed from version > 2.1.6"
          end

          if config.trailblazer.enable_loader || config.trailblazer.use_loader
            reloader_class.to_prepare do
              Trailblazer::Railtie.load_concepts(app)
            end
          end
        end
      end
    end
  end
end
