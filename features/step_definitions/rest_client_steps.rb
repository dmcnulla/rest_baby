DEFAULT_MSG = '{"Answer": "What did you expect?"}'
DEFAULT_RESPONSE = '{"Question": "What is the meaning of life?"}'
DEFAULT_XML = '<Questions><Question>What is the meaning of life?</Question></Questions>'
XML_HEADERS = {
  'Content-Type' => 'application/xml',
  'Accept' => 'application/xml'
}

Given(/^I have a web service$/) do
  @protocol = 'http'
  @server = FigNewton.server
  @port = FigNewton.port
  @mockservice = MockRestService.new(@server, @port, @protocol)
end

Given(/^I have "(GET|PUT|POST|DELETE)" service for "([^"]*)"$/) do |type, path|
  @path = path
  if type == 'GET'
    create_get(path)
  else
    @path = path
    @mockservice.store_msg(type, path, DEFAULT_MSG,
                           {}, nil, nil, DEFAULT_RESPONSE)
  end
end

Given(/^I have "(PUT|POST)" service for "([^"]*)" that requires no body$/) do |type, path|
  @path = path
  @path = path
  @mockservice.store_msg(type, path, nil,
                         {}, nil, nil, nil)
end

Given(/^I have an xml service for "([^"]*)"$/) do |path|
  @path = path
  @mockservice.store_msg('POST', path, DEFAULT_XML,
                         XML_HEADERS, nil, nil, DEFAULT_XML)
end

Given(/^I have "(GET|PUT|POST|DELETE)" service for "([^"]*)" as follows$/) \
do |type, path, message|
  @path = path
  if type == 'GET'
    create_get(path, message)
  else
    @mockservice.store_msg(type, path, DEFAULT_MSG, {}, nil, nil, message)
  end
end

def create_get(path, message = DEFAULT_MSG)
  @path = path.split('?')[0]
  if path.split('?').length == 1
    @mockservice.store_msg('GET', @path, message.to_s)
  else
    @mockservice.store_get_query(path)
  end
end

Given(/^I am a rest client$/) do
  @restbaby = Client.new("#{@protocol}://#{@server}:#{@port}#{@path}")
end

When(/^I "(GET|DELETE)" from the web service$/) do |type|
  case type.downcase
  when 'get'
    @response = @restbaby.get
  when 'delete'
    @response = @restbaby.delete
  end
end

When(/^I "(.*?)" to the web service with the following xml$/) do |type, message|
  @message = message.strip
  case type.downcase
  when 'put'
    @response = @restbaby.put(@message, XML_HEADERS)
  when 'post'
    @response = @restbaby.post(@message, XML_HEADERS)
  end
end

When(/^I "(PUT|POST)" to the web service with the following$/) \
do |type, message|
  @message = message.strip
  case type.downcase
  when 'put'
    @response = @restbaby.put(@message)
  when 'post'
    @response = @restbaby.post(@message)
  end
end

When(/^I "(PUT|POST)" to the web service with no body$/) do |type|
  case type.downcase
  when 'put'
    @response = @restbaby.put()
  when 'post'
    @response = @restbaby.post()
  end
end

When(/^I "GET" from the web service with the parameters$/) do |table|
  @response = @restbaby.get({}, nil, table.rows_hash)
end

When(/^I pause$/) do
  pause
end

Then(/^I receive the expected message$/) do
  expect(@response.code).to eq('200')
  expect(@response.body).to eq(DEFAULT_MSG)
end

Then(/^I receive a message with "([^"]*)"$/) do |message|
  expect(@response.code).to eq('200')
  expect(@response.body).to eq(message)
end

Then(/^I receive the xml message$/) do
  expect(@response.code).to eq('200')
  expect(@response.body).to eq(DEFAULT_XML)
end

Then(/^I receive the no message$/) do
  expect(@response.code).to eq('200')
  expect(@response.body).to be_nil
end

