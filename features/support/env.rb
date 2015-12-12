require 'rspec/expectations'
require 'fig_newton'
require 'cucumber/rspec/doubles'
require 'rubygems'
require 'webmock/cucumber'
require 'coveralls'
require File.expand_path(File.join(File.dirname(__FILE__),
                                   '..', '..', 'lib', 'rest_baby.rb'))

include RestBaby

Coveralls.wear!

puts "Using environment in #{ENV['FIG_NEWTON_FILE']}"
FigNewton.load(ENV['FIG_NEWTON_FILE'])
