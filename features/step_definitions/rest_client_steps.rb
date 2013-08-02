Given(/^I have a web service$/) do
	@server = FigNewton.server
	@port = FigNewton.port
  @mockservice = MockRestService.new(@server, @port)
end

Given(/^I have "(GET|PUT|POST|DELETE)" service for "(.*?)" as follows$/) do |type, path, message|
	@path = path
	@mockservice.store_msg(type, path, message)
end

Given(/^I am a rest client$/) do
	@restbaby = RestBaby.new("http://#{@server}:#{@port}#{@path}")
end

When(/^I "(GET|DELETE)" from the web service$/) do |type|
	case type.downcase
	when 'get'
		@response = @restbaby.get(@path)
	when 'delete'
		@response = @restbaby.delete(@path)
	end
end

When(/^I "(PUT|POST)" to the web service with the following$/) do |type, message|
	case type.downcase
	when 'put'
		@response = @restbaby.put(@path, message)
	when 'post'
		@response = @restbaby.post(@path, message)
	end
end

When(/^I have the following headers?$/) do |table|
	@restbaby.set_headers(table.rows_hash)
end

When(/^I pause$/) do
  pause()
end

Then(/^I receive the following$/) do |message|
	expect(@response.code).to eq('200')
	expect(@response.body).to eq(message)
end

Then(/^the response prints like the following$/) do |response|
  expect(@restbaby.print_last_response).to eq(response)
end
