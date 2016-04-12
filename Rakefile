require 'bundler/gem_tasks'
require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'coveralls/rake/task'
require 'rubocop/rake_task'

desc 'Run lint check RuboCop'
task :rubocop do
  begin
    RuboCop::RakeTask.new do |t|
      t.formatters = %w(files offenses)
      t.options = [['--config', '.rubocop.yml']]
      t.fail_on_error = true
    end
  rescue
    puts 'Rubocop did not run'
  end
end

desc 'Test'
Cucumber::Rake::Task.new(:features) do |t|
  t.profile = 'default'
end

desc 'Check test coverage'
Coveralls::RakeTask.new

task default: [:features, 'coveralls:push']
