DEFAULT_MESSAGE = "{'Answer': 'What did you expect?'}"

Given(/^I have a web service$/) do
	@protocol = 'http'
	@server = FigNewton.server
	@port = FigNewton.port
  @mockservice = MockRestService.new(@server, @port, @protocol)
end

Given(/^I have "(GET|PUT|POST|DELETE)" service for "(.*?)"$/) do |type, path|
	@path = path
	@mockservice.store_msg(type, path, DEFAULT_MESSAGE)
end

Given(/^I have "(GET|PUT|POST|DELETE)" service for "(.*?)" as follows$/) do |type, path, message|
	@path = path
	@mockservice.store_msg(type, path, message)
end

Given(/^I am a rest client$/) do
	@restbaby = Client.new("#{@protocol}://#{@server}:#{@port}#{@path}")
end

When(/^I "(GET|DELETE)" from the web service$/) do |type|
	case type.downcase
	when 'get'
		@response = @restbaby.get
	when 'delete'
		# @response = @restbaby.delete(@path)
		@response = @restbaby.delete
	end
end

When(/^I "(PUT|POST)" to the web service with the following$/) do |type, message|
	case type.downcase
	when 'put'
		@response = @restbaby.put(message)
	when 'post'
		@response = @restbaby.post(message)
	end
end

When(/^I pause$/) do
  pause()
end

Then(/^I receive the expected message$/) do
	expect(@response.code).to eq('200')
	expect(@response.body).to eq(DEFAULT_MESSAGE)
end

Then(/^I receive the following$/) do |message|
	expect(@response.code).to eq('200')
	expect(@response.body).to eq(message)
end

Then(/^the response prints like the following$/) do |response|
  expect(@restbaby.print_last_response).to eq(response)
end
