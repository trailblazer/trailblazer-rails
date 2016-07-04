require 'trailblazer'
require 'minitest/autorun'


require 'active_record'
require 'database_cleaner'
ActiveRecord::Base.logger = false
ActiveRecord::Base.establish_connection(
  adapter:  "sqlite3",
  database: ":memory:"
)

# Dot not show Active Record Migrations
ActiveRecord::Migration.verbose = false
ActiveRecord::Schema.define do
  create_table :things do |table|
    table.column :title, :string
    table.column :active, :boolean, default: true
  end

  create_table(:bands) do |table|
    table.column :name, :string
    table.column :locality, :string
  end
end
DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with(:truncation)


# FIXME: we HAVE to use a testing setup similar to cells-rails (separate rails app, run tests).
require 'fake_app/rails_app.rb'
require 'fake_app/controllers'
require 'fake_app/models'
require 'fake_app/song/operations.rb'


require 'fileutils'
FileUtils::mkdir_p '/tmp/uploads'


module TmpUploads
  def self.included(includer)
    includer.class_eval do
      let (:tmp_dir) { "/tmp/uploads" }
      before { Dir.mkdir(tmp_dir) unless File.exists?(tmp_dir) }
    end
  end
end

MiniTest::Spec.class_eval do
  include TmpUploads

  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end
