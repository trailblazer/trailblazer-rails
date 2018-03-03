require "rails/railtie"
require "trailblazer/loader"

module Trailblazer
  class Railtie < ::Rails::Railtie
    config.trailblazer = ActiveSupport::OrderedOptions.new
    ## Accept also an Array of controllers
    config.trailblazer.application_controller ||= 'ActionController::Base'
    config.trailblazer.use_loader ||= true
    config.trailblazer.shortened_folders ||= 'operation'

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
      Loader.new.(prepend: AllModelFiles, root: app.root) { |file| require_file(file) }
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

    initializer "trailblazer.application_controller", before: "finisher_hook" do |app|
      reloader_class.to_prepare do
        ActiveSupport.on_load(:action_controller) do |app|
          Trailblazer::Railtie.extend_application_controller!(app)
        end
      end
    end

    # Prepend model file, before the concept files like operation.rb get loaded.
    ModelFile = ->(input, options) do
      model = "app/models/#{options[:name]}.rb"
      File.exist?(model) ? [model]+input : input
    end

    # Load all model files before any TRB files.
    AllModelFiles = ->(input, options) do
      Dir.glob("#{options[:root]}/app/models/**/*.rb") + input
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

    # using trb_require_dependency to avoid multi invocations for Trb::Operation
    # this logic follows the TRB convention:
    #   - file structure -> app/concepts/model/operation/action.rb
    # it checks if 2 elements after concepts includes what set in shortened_folders
    # so calls trb_require_dependency for all operations files
    def self.require_file(file)
      array = file.split('/')
      index = array.index('concepts')
      if !index.nil? && array[index+2].include?(config.trailblazer.shortened_folders)
        trb_require_dependency(file, get_constant_path(array, index))
      else
        require_dependency(file)
      end
    end

    # get path array '[,bla,bla,bla,app,concepts,really_cool,operation,amazing_action.rb]'
    # and index of the concepts folder
    # returns 'ReallyCool::AmazingAction'
    def self.get_constant_path(array, index)
      return unless [array[index+1],array[index+3]].all?(&:present?)
      [array[index+1].camelize,array[index+3].camelize].join('::').remove('.rb')
    end

    # as per fxn suggestion https://github.com/dry-rb/dry-types/issues/18#issuecomment-357450577
    def self.trb_require_dependency(file_name, constant_path)
      loaded = require_dependency(file_name)

      if loaded && !::Rails.application.config.cache_classes
        if eval "defined?(#{constant_path})"
          ActiveSupport::Dependencies.autoloaded_constants << constant_path
        else
          raise "#{file_name}.rb was expected to define #{constant_path}"
        end
      end

      loaded
    end

    module ExtendApplicationController
      def extend_application_controller!(app)
        controllers = Array(::Rails.application.config.trailblazer.application_controller).map{ |x| x.to_s }
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
