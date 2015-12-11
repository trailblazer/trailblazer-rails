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

      files = []

      # Picks up everything in the root of concepts, ie app/concepts/app_cell.rb
      # - essentially classes that all concepts can inherit from.
      # So all top level items such will get loaded as long as file name includes _item.rb
      # Like app/concepts/app_cell.rb or app/concepts/default_customer_cell.rb
      files = files | Dir[app.root.join('app', 'concepts',"*{#{items}}.rb")]

      # Picks up in the root of the concept - like app/concepts/comments/operation.rb
      files = files | Dir[app.root.join('app', 'concepts','*', "{#{items}}.rb")]

      # Picks up everything in the root appropriate folder ie app/concepts/comments/operation/operation.rb
      # This will make sure to load operation.rb before  create.rb - helpful with cells
      # When  you have app/concepts/cell/cell.rb & app/concepts/cell/apple.rb and cell.rb needs to be loaded first.
      files = files | Dir[app.root.join('app', 'concepts','*', "{#{items}}","{#{items}}.rb")]

      # Pick up everything else in the item folder operations/create.rb or opertations/update.rb - except operation.rb
      files = files | Dir[app.root.join('app', 'concepts','*', "{#{items}}",'*.rb')]

      # FIXME
      # Address a case when there is deeper nesting - thou it's too much
      # like app/concepts/comments/special_comments/cell/form.rb  -?

      # Require all
      files.each do |f|
         require_dependency "#{f}"
      end
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
        Trailblazer::Railtie.autoload_items(app,'model')
        Trailblazer::Railtie.autoload_items(app,'policy')
        Trailblazer::Railtie.autoload_items(app,'representer')
        Trailblazer::Railtie.autoload_items(app,'contract,form')
        Trailblazer::Railtie.autoload_items(app,'callback')
        Trailblazer::Railtie.autoload_items(app,'operation')
        Trailblazer::Railtie.autoload_items(app,'cell,cells')
      end
    end
  end
end