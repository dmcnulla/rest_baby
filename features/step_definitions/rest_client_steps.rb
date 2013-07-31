Given(/^I have a mocked web service$/) do
	@server = FigNewton.server
	@port = FigNewton.port
  @mockservice = MockRestService.new(@server, @port)
end

Given(/^I have "(GET|PUT|POST|DELETE)" service for "(.*?)" as follows$/) do |type, path, message|
	@mockservice.store_msg(type, path, message)
end

When(/^I "(GET|DELETE)" from "(.*?)"$/) do |type, path|
	@restbaby = RestBaby.new("http://#{@server}:#{@port}#{path}")
	case type.downcase
	when 'get'
		@response = @restbaby.get(path)
	when 'delete'
		@response = @restbaby.delete(path)
	end
end

When(/^I "(PUT|POST)" to "(.*?)" with the following$/) do |type, path, message|
	@restbaby = RestBaby.new("http://#{@server}:#{@port}#{path}")
	case type.downcase
	when 'put'
		@response = @restbaby.put(path, message)
	when 'post'
		@response = @restbaby.post(path, message)
	end
end

When(/^I pause$/) do
  pause()
end


Then(/^I receive the following$/) do |message|
	expect(@response.code).to eq('200')
	expect(@response.body).to eq(message)
end