source 'https://rubygems.org'

gem 'json'
gem 'nokogiri'

group :development do
  gem 'bundler'
  gem 'rake'
  gem 'cucumber'
  gem 'fig_newton'
  gem 'rspec'
  gem 'webmock'
  gem 'coveralls'
  gem 'simplecov'
  gem 'rubocop'
  if ENV['JRUBY'] || RUBY_PLATFORM == 'java'
    # Skip the yard gems for jruby
  else
    gem 'reek'
    gem 'yard'
    gem 'yard-cucumber'
    gem 'redcarpet'
  end
end
