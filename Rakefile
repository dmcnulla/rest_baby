require 'bundler/gem_tasks'
require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
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

task default: :features

task :clean do
  `rm -rf doc`
  `rm -rf .yardoc`
  `git checkout doc`
end
