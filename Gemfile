source 'https://rubygems.org'

gemspec

group :development do
  gem 'rubocop'
  if RUBY_VERSION[0].to_i > 1
    gem 'reek'
  end
end

group :documentation do
  if not(ENV['JRUBY'] || RUBY_PLATFORM == 'java')
    gem 'yard'
    gem 'yard-cucumber'
    gem 'redcarpet'
  end
end
