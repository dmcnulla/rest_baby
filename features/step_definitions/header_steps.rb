Given(/^I have a secure web service$/) do
	@protocol = 'https'
 	@server = FigNewton.server
	@port = FigNewton.port
	@mockservice = MockRestService.new(@server, @port, @protocol)
end

Given(/^I have "(GET|PUT|POST|DELETE)" service for "(.*?)" with the following headers$/) do |type, path, table|
	@path = path
	@mockservice.store_msg(type, path, DEFAULT_MESSAGE, table.rows_hash)
end

When(/^I have the following headers?$/) do |table|
	@restbaby.set_headers(table.rows_hash)
end

Given(/^I have basic auth for user "(.*?)" and password "(.*?)"$/) do |user, password|
	@restbaby.set_auth(user, password)
end
