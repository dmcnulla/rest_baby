require 'webmock/cucumber'
# include PinchHitter

class MockRestService

  STANDARD_HEADERS = {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}
  STANDARD = "http"
  SECURE = "https"

  def initialize(host, port, protocol = STANDARD)
    @protocol = protocol
    @host = host
    @port = port
    @messages = {}
  end  

  def store_msg(type, path, message, headers = {}, user = nil, password = nil)
    new_headers = STANDARD_HEADERS.merge(headers)
    auth_string = "#{user}:#{password}@" unless (user.nil? || password.nil?)
    case type.downcase
      when "get", "delete"
        WebMock.stub_request(type.downcase.to_sym, "#{@protocol}://#{auth_string}#{@host}:#{@port}#{path}").
          with(:headers => new_headers).
          to_return({:body => "#{message}", :status => 200}, :headers => {})
      when "post", "put"
        WebMock.stub_request(type.downcase.to_sym, "#{@protocol}://#{auth_string}#{@host}:#{@port}#{path}").
          with(:headers => new_headers).
          to_return(:status => 200, :body => "#{message}", :headers => {})
      else
        raise "Unsupported type: #{type}"
    end
  end    

  # def initialize(host, port)
  #   @host = host
  #   @port = port
  #   self.start_service @host, @port
  #   self.connect @host, @port
  #   self.messages_directory = File.join(File.dirname('.'), "..", "..", 'features', 'messages')
  # end

  # def store_msg(path, message)
  #   store path, message
  # end

  # def close
  #   self.stop_service
  # end

end
