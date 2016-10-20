source 'https://rubygems.org'

gemspec

version = RUBY_VERSION[0..2].split('.')[0..1].join('.').to_f
group :development do
  gem 'rubocop'
  if version > 2.0
    gem 'reek'
  end
end

group :documentation do
  if not(ENV['JRUBY'] || RUBY_PLATFORM == 'java')
    gem 'yard'
    gem 'yard-cucumber', git: 'https://github.com/burtlo/yard-cucumber'
    gem 'redcarpet'
  end
end
