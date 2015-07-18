require 'bundler/gem_tasks'
require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'yard'
require 'yard/rake/yardoc_task'

Cucumber::Rake::Task.new(:features) do |t|
  t.profile = 'default'
end

task default: :features

YARD::Rake::YardocTask.new do |t|
  t.files   = ['features/**/*.feature', 'features/**/*.rb']
end

Rake::Task["release"].enhance do
  sh "gem push #{gem.package_dir}/#{gem.gem_file}"
end
