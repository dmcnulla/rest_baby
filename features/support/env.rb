require 'rspec/expectations'
require 'fig_newton'
require 'cucumber/rspec/doubles'
require 'rubygems'
require 'webmock/cucumber'
require 'coveralls'
require 'simplecov'

puts "Using environment in #{ENV['FIG_NEWTON_FILE']}"
FigNewton.load(ENV['FIG_NEWTON_FILE'])

COVERAGE_ARRAY = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
].freeze

SimpleCov.formatter =
  SimpleCov::Formatter::MultiFormatter.new(COVERAGE_ARRAY)

SimpleCov.start do
  add_filter 'features'
end

require File.expand_path(File.join(File.dirname(__FILE__),
                                   '..', '..', 'lib', 'rest_baby.rb'))

include RestBaby
