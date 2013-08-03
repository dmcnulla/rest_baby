require 'rspec-expectations'
require 'fig_newton'
require 'net/http'
require 'net/https'
require 'pinch_hitter'
require 'cucumber/rspec/doubles'
require 'rubygems'
require 'webmock/cucumber'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "lib", "rest_baby.rb"))
require 'logger'

include RestBaby

mylog = Logger.new(STDOUT)
mylog.level = case FigNewton.log_level.upcase
	when 'FATAL'
		Logger::WARN
	when 'ERROR'
		Logger::WARN
	when 'WARN'
		Logger::WARN
	when 'INFO'
		Logger::WARN
	when 'DEBUG'
		Logger::DEBUG
	else
		Logger::UNKNOWN
end

mylog.info "Using environment in #{ENV['FIG_NEWTON_FILE']}"
FigNewton.load(ENV['FIG_NEWTON_FILE'])
