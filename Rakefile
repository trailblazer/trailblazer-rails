require "bundler/gem_tasks"
require "rake/testtask"
ENV["RAILS_ENV"] = "test"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

begin
  require File.expand_path("test/dummy/config/application", __dir__)
  Rails.application.load_tasks
rescue LoadError
end

desc "Running Tests"
task default: :test
