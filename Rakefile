require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

desc "Remove temporary files"
task :clean do
  `rm -rf *.gem doc pkg coverage test-reports`
  %x(rm -f `find . -name '*.rbc'`)
end

desc "Running Tests"
task default: %i[clean test]
