require "rails/railtie"

module Trailblazer
  class Railtie < ::Rails::Railtie
    def self.autoload_items(app, items)
      # Pick up default operation.rb or crud.rb - without folder structure
      # This assumes on of the following patterns
      # app_root/app/concepts/comments/opertaion.rb
      # and either / or
      # app_root/app/concepts/comments/opertaion/create.rb
      # app_root/app/concepts/comments/opertaion/special_operation.rb
      # app_root/app/concepts/comments/opertaion/comment_operation.rb

      # Picks up everything in the root of concepts, ie app_cell.rb
      files = Dir.glob("#{app.root}/app/concepts/*{#{items}}.rb")
      # Picks up everything in the root appropriate folder ie app/concepts/operation/operation.rb
      # This will make sure to load operation.rb before  create.rb - helpful with cells
      # When  you have app/concepts/cell/cell.rb & app/concepts/cell/apple.rb and cell.rb needs to be loaded first.
      files += Dir.glob("#{app.root}/app/concepts/**/{#{items}}/{#{items}}.rb")
      # Pick up everything else in the item folder operations/create.rb or opertations/update.rb - except operation.rb
      files += Dir.glob("#{app.root}/app/concepts/**/{#{items}}/**[^#{items}].rb")
      # FIXME
      # Address a case when there is deeper nesting - thou it's too much
      # like app/concepts/comments/special_comments/cell/form.rb  -?
      
      # Add to Rails autload paths
      app.config.autoload_paths += files
      
      # Require all
      files.each do |f|
         require_dependency "#{f}"
      end
    end

    def self.autoload_operations(app)
      self.autoload_items(app,'opertaion,opertaions')
    end

    def self.autoload_models(app)
      self.autoload_items(app,'model,models')
    end

    def self.autoload_cells(app)
      self.autoload_items(app,'cell,cells')
    end

    def self.autoload_contracts(app)
      # Some people call them contracts, some people call them forms - It's Reform object.
      self.autoload_items(app,'contract,contracts,forms,form')
    end

    def self.autoload_callbacks(app)
      self.autoload_items(app,'callback,callbacks')
    end

     def self.autoload_policies(app)
      self.autoload_items(app,'policy,policies')
    end

    def self.autoload_representers(app)
      # Same idea as autoload_operations - no need for duplicate comments.
      # Some people refer to them as decorators
      self.autoload_items(app,'representers,decorators,representer,decorator')
    end

    # This is to autoload Operation::Dispatch, etc. I'm simply assuming people find this helpful in Rails.
    initializer "trailblazer.library_autoloading" do
      require "trailblazer/autoloading"
    end

    # thank you, http://stackoverflow.com/a/17573888/465070
    initializer 'trailblazer.install', after: :load_config_initializers do |app|
      # the trb autoloading has to be run after initializers have been loaded, so we can tweak inclusion of features in
      # initializers.
      ActionDispatch::Reloader.to_prepare do
        Trailblazer::Railtie.autoload_models(app)
        Trailblazer::Railtie.autoload_policies(app)
        Trailblazer::Railtie.autoload_representers(app)
        Trailblazer::Railtie.autoload_contracts(app)
        Trailblazer::Railtie.autoload_callbacks(app)
        Trailblazer::Railtie.autoload_operations(app)
        Trailblazer::Railtie.autoload_cells(app)
      end
    end
  end
end
