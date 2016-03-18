require 'bundler/gem_tasks'
require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'coveralls/rake/task'
require 'reek/rake/task'

Reek::Rake::Task.new do |t|
  t.name          = 'reek'
  t.config_file   = 'config/config.reek'
  t.source_files  = 'lib/**/*.rb'
  t.reek_opts     = '-U'
  t.fail_on_error = true
  t.verbose       = true
end

if ENV['JRUBY'] || RUBY_PLATFORM == 'java'
  # Skip the yard gems for jruby
else
  require 'yard'
  # rake yard
  YARD::Rake::YardocTask.new do |t|
    t.files = ['lib/**/*.rb', 'features/**/*.feature', 'features/**/*.rb']
  end
end

Cucumber::Rake::Task.new(:features) do |t|
  t.profile = 'default'
end

Coveralls::RakeTask.new

task default: [:features, 'coveralls:push']

task :clean do
  `rm -rf doc`
  `rm -rf .yardoc`
  `git checkout doc`
end
