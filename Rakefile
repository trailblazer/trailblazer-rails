require "bundler/gem_tasks"
require "rake/testtask"
require "rubocop/rake_task"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

RuboCop::RakeTask.new(:rubocop)

desc 'Remove temporary files'
task :clean do
  `rm -rf *.gem doc pkg coverage test-reports`
  %x(rm -f `find . -name '*.rbc'`)
end

desc "Build the gem"
task :gem do
  `gem build trailblazer-rails.gemspec`
end

desc 'Running Tests'
task default: %i[clean test]
