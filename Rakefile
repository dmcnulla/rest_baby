require 'bundler/gem_tasks'
require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'coveralls/rake/task'
require 'rubocop/rake_task'

desc 'Run lint check RuboCop'
task :rubocop do
  RuboCop::RakeTask.new do |t|
    t.formatters = %w(files offenses)
    t.options = [['--config', 'config/rubocop.yml']]
    t.fail_on_error = true
  end
end

desc 'Test'
Cucumber::Rake::Task.new(:features) do |t|
  t.profile = 'default'
end

desc 'Check test coverage'
Coveralls::RakeTask.new

task :clean do
  `rm -rf doc`
  `rm -rf .yardoc`
  `git checkout doc`
end

if ENV['JRUBY'] || RUBY_PLATFORM == 'java'
  # jruby default rake task
  task default: [:features, 'coveralls:push', :rubocop]
else
  desc 'Run lint check Reek'
  require 'reek/rake/task'
  Reek::Rake::Task.new(:lint) do |t|
    t.name          = 'reek'
    t.config_file   = 'config/config.reek'
    t.source_files  = 'lib/**/*.rb'
    t.reek_opts     = '-U'
    t.fail_on_error = true
    t.verbose       = true
  end

  desc 'Documentation'
  require 'yard'
  YARD::Rake::YardocTask.new do |t|
    t.files = ['lib/**/*.rb', 'features/**/*.feature', 'features/**/*.rb']
  end

  # regular ruby default rake task
  task default: [:features, 'coveralls:push', :rubocop, :reek]
end
