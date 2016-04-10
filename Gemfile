source 'https://rubygems.org'

gemspec

group :development do
  gem 'rubocop'
  if RUBY_VERSION[0].split('.')[0..1].join('.').to_f > 2.0
    gem 'reek'
  end
end

group :documentation do
  if not(ENV['JRUBY'] || RUBY_PLATFORM == 'java')
    gem 'yard'
    gem 'yard-cucumber', github: 'burtlo/yard-cucumber'
    gem 'redcarpet'
  end
end
