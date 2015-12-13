require 'rspec/expectations'
require 'fig_newton'
require 'cucumber/rspec/doubles'
require 'rubygems'
require 'webmock/cucumber'
# require 'coveralls'
# require 'simplecov'
require File.expand_path(File.join(File.dirname(__FILE__),
                                   '..', '..', 'lib', 'rest_baby.rb'))

include RestBaby

# SimpleCov.formatter = Coveralls::SimpleCov::Formatter
# SimpleCov.start do
#   add_filter 'features'
# end
# Coveralls.wear!

puts "Using environment in #{ENV['FIG_NEWTON_FILE']}"
FigNewton.load(ENV['FIG_NEWTON_FILE'])
