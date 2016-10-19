# rest_baby

Small rest client, supports ruby-2.0.0, ruby-2.1.0, and ruby-2.2.0. You can only run reek with ruby 2.1 or above. You *could* use jruby but some develop dependencies are not supported any longer, including coveralls and yard-cucumber.

Item | Status
--- | ---
Gem | [![Gem Version](https://badge.fury.io/rb/rest_baby.svg)](https://badge.fury.io/rb/rest_baby )
Dependencies | [![Dependency Status](https://gemnasium.com/dmcnulla/rest_baby.svg)](https://gemnasium.com/dmcnulla/rest_baby)
Build/Test | [![Build Status](https://travis-ci.org/dmcnulla/rest_baby.svg?branch=master)](https://travis-ci.org/dmcnulla/rest_baby)
Coverage | [![Coverage Status](https://coveralls.io/repos/dmcnulla/rest_baby/badge.svg?branch=v1_5&service=github)](https://coveralls.io/github/dmcnulla/rest_baby?branch=v1_5)
Code Analysis | [![Code Climate](https://codeclimate.com/github/dmcnulla/rest_baby/badges/gpa.svg)](https://codeclimate.com/github/dmcnulla/rest_baby)
Docs | [![Inline docs](http://inch-ci.org/github/dmcnulla/rest_baby.svg?branch=master)](http://inch-ci.org/github/dmcnulla/rest_baby)
codeship | [ ![Codeship Status for dmcnulla/rest_baby](https://codeship.com/projects/6002d4e0-efc4-0133-4e00-7aa0b68b0e4b/status?branch=master)](https://codeship.com/projects/149095)

## Purpose

Rest_baby is a rest client that retains key server & authorization settings, keeping your code dryer. It has been used for automated tools that test restful interfaces. It has grown to over 5k downloads with only 5 reported issues as of this writing.

## Installation

Add this line to your application's Gemfile:

	gem 'rest_baby'

And then execute:

	$ bundle

Or install it yourself as:

	$ gem install rest_baby

## Use

```ruby
client = RestBaby::Client.new('http://gis.srh.noaa.gov/arcgis/rest/services/System')
# get(HEADERS, PATH, PARAMETERS)
# returns http response, usually the body is what is wanted.
message = JSON.parse(client.get( { 'Accept' => 'application/json' },
                                   '/ReportingTools/GPServer/info/iteminfo',
                                   {'f' => 'pjson'}).body)

client = RestBaby::Client.new('http://127.0.0.1:9001')
# post(BODY, HEADERS, PATH)
message = JSON.parse(client.post('{ "name": "Ben Franklin" }',
                                { 'Content-Type' => 'application/json' },
                                '/person').body)
# or
message = JSON.parse(client.post({ "name" => "Ben Franklin" }.to_json,
                                 { 'Content-Type' => 'application/json' },
                                 '/person').body)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
