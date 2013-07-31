require 'rspec-expectations'
require 'fig_newton'
require 'net/http'
require 'net/https'
require 'pinch_hitter'
require 'cucumber/rspec/doubles'
require 'rubygems'
require 'webmock/cucumber'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "rest_baby.rb"))


# puts "Using environment in #{ENV['FIG_NEWTON_FILE']}"
FigNewton.load(ENV['FIG_NEWTON_FILE'])
