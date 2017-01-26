module Trailblazer
  module Generators
    class ConceptGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def create_concept_files
        underscored_file_path = file_path.tr('/', '_')

        template "operation/new.rb", "app/concepts/#{underscored_file_path}/operation/new.rb"
        template "operation/create.rb", "app/concepts/#{underscored_file_path}/operation/create.rb"
        template "operation/update.rb", "app/concepts/#{underscored_file_path}/operation/update.rb"

        template "contract/create.rb", "app/concepts/#{underscored_file_path}/contract/create.rb"
        template "contract/update.rb", "app/concepts/#{underscored_file_path}/contract/update.rb"
      end
    end
  end
end
