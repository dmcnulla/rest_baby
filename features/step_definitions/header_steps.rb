Given(/^I have a secure web service$/) do
  @protocol = 'https'
  @server = FigNewton.server
  @port = FigNewton.port
  @mockservice = MockRestService.new(@server, @port, @protocol)
end

Given(/^I have "(GET|PUT|POST|DELETE)" service for "([^"]*)" \
with the following headers$/) do |type, path, table|
  @path = path
  @mockservice.store_msg(type, path, DEFAULT_MSG, table.rows_hash, nil, nil, DEFAULT_RESPONSE)
end

Given(/^I have "(GET|DELETE)" service for "([^"]*)" for \
user "([^"]*)" and password "([^"]*)"$/) do |type, path, user, password|
  @path = path
  message = hasParams(path) ? path.split('?')[1] : DEFAULT_MSG
  @mockservice.store_msg(type, path, message, {}, user, password)
end

def hasParams(path)
  path.include?('?')
end

Given(/^I have "(PUT|POST)" service for "([^"]*)" for \
user "([^"]*)" and password "([^"]*)"$/) do |type, path, user, password, table|
  @path = path
  @headers = table.rows_hash
  @mockservice.store_msg(type, path, DEFAULT_MSG, @headers, user, password)
end

When(/^I have the following headers?$/) do |table|
  @restbaby.add_headers(table.rows_hash)
end

Given(/^I have basic auth for user "([^"]*)" \
and password "(.*?)"$/) do |user, password|
  @restbaby.set_auth(user, password)
end
