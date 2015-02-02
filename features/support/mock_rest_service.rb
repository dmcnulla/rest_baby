require 'webmock/cucumber'

include WebMock::API

# Mocking Service for testing rest calls
class MockRestService
  STANDARD_HEADERS = { 'Accept' => '*/*', 'User-Agent' => 'Ruby' }
  STANDARD = 'http'
  SECURE = 'https'

  def initialize(host, port, protocol = STANDARD)
    @protocol = protocol
    @host = host
    @port = port
    @messages = {}
  end

  def store_msg(type, path, message, headers = {}, user = nil, password = nil)
    url = "#{@protocol}://#{auth_string(user, password)}#{@host}:#{@port}#{path}"
    case type.downcase
    when 'get', 'delete'
      WebMock.stub_request(type.downcase.to_sym, url)
        .with(headers: merge_headers(headers))
        .to_return({ status: 200, body: "#{message}" }, headers: {})
    when 'put', 'post'
      WebMock.stub_request(:put, url)
        .with(body: body,
              headers: merge_headers(headers))
        .to_return({ status: 200, body: "#{message}" }, headers: {})
    else
      fail "Unsupported type: #{type}"
    end
  end

  def merge_headers(headers)
    STANDARD_HEADERS.merge(headers)
  end

  def auth_string(user, password)
    "#{user}:#{password}@" unless user.nil? || password.nil?
  end

  def store_get_query(path, headers = {}, user = nil, password = nil)
    new_headers = STANDARD_HEADERS.merge(headers)
    message = path.split('?').last
    auth_string = "#{user}:#{password}@" unless user.nil? || password.nil?
    WebMock.stub_request(:get,
                         "#{@protocol}://#{auth_string}#{@host}:#{@port}#{path}")
      .with(headers: new_headers)
      .to_return({ body: "#{message}", status: 200 }, headers: {})
  end
end
