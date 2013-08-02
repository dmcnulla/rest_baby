include PinchHitter

class PinchRestService

  def initialize(host, port)
    @host = host
    @port = port
    self.start_service @host, @port
    self.connect @host, @port
    self.messages_directory = File.join(File.dirname('.'), "..", "..", 'features', 'messages')
  end

  def store_msg(path, message)
    store path, message
  end

  def close
    self.stop_service
  end

end
