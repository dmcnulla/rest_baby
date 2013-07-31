require 'webmock/cucumber'
# include PinchHitter

class MockRestService
  def initialize(host, port)
    @host = host
    @port = port
    @messages = {}
  end

  def store_msg(type, path, message)
    case type.downcase
    when "get", "delete"
      WebMock.stub_request(type.downcase.to_sym, "http://#{@host}:#{@port}#{path}").
        to_return({:body => "#{message}", :status => 200})
    when "post", "put"
      WebMock.stub_request(type.downcase.to_sym, "http://#{@host}:#{@port}#{path}").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
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
