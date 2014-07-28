DEFAULT_MESSAGE = "{'Answer': 'What did you expect?'}"

Given(/^I have a web service$/) do
	@protocol = 'http'
	@server = FigNewton.server
	@port = FigNewton.port
	@mockservice = MockRestService.new(@server, @port, @protocol)
end

Given(/^I have "(GET|PUT|POST|DELETE)" service for "(.*?)"$/) do |type, path|
	if type=="GET"
		create_get(type, path)
	else
		@path = path
		@mockservice.store_msg(type, path, DEFAULT_MESSAGE)
	end
end

Given(/^I have "(GET|PUT|POST|DELETE)" service for "(.*?)" as follows$/) do |type, path, message|
	if type=="GET"
		create_get(type, path, message)
	else
		@path = path
		@mockservice.store_msg(type, path, message)
	end
end

def create_get(type, path, message = DEFAULT_MESSAGE)
	@path = path.split('?')[0]
	if path.split('?').length==1
		@mockservice.store_msg("GET", @path, message)
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

When(/^I "(PUT|POST)" to the web service with the following$/) do |type, message|
	case type.downcase
	when 'put'
		@response = @restbaby.put(message)
	when 'post'
		@response = @restbaby.post(message)
	end
end

When(/^I "GET" from the web service with the parameters$/) do |table|
	@response = @restbaby.get({}, nil, table.rows_hash)
end

When(/^I pause$/) do
  pause()
end

Then(/^I receive the expected message$/) do
	@response.code.should eq('200')
	@response.body.should eq(DEFAULT_MESSAGE)
end

# Then(/^I receive the following$/) do |message|
# 	@response.code.should eq('200')
# 	@response.body.should eq(message)
# end

Then(/^I receive a message with "(.*?)"$/) do |message|
	@response.code.should eq('200')
	@response.body.should eq(message)
end
