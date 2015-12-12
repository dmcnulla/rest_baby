require 'bundler/gem_tasks'
require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'yard'

Cucumber::Rake::Task.new(:features) do |t|
  t.profile = 'default'
end

task default: :features

# rake yard
YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb', 'features/**/*.feature', 'features/**/*.rb']
end

task :clean do
  `rm -rf doc`
  `rm -rf .yardoc`
  `git checkout doc`
end
