require "bundler/gem_tasks"
require "rake/testtask"
ENV["RAILS_ENV"] = "test"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end


require File.expand_path("test/dummy/config/application", __dir__)

Rails.application.load_tasks

desc "Running Tests"
task default: ["db:create", :test]
