=begin rdoc

== Authors

Dave McNulla

== Revision Log

2013.07.30	initial files for a simple rest client

=end

class RestBaby
	attr_accessor :contentType, :uri, :wsresponse, :xId 

	def initialize(url, options = {})
		@uri = URI.parse(url)
	end

	#Basic web services Get command
	# * url = url to send the command to
	def get(path)
		return request(uri, Net::HTTP::Get.new(@uri.request_uri))
	end

	#Basic web services Post command
	# * url = url to send the command to
	# * body = data to put in the body
	def post(path, body = nil)
		return request(uri, Net::HTTP::Post.new(@uri.request_uri), body)
	end

	#Basic web services Delete command
	# * url = url to send the command to
	def delete(path)
		return request(uri, Net::HTTP::Delete.new(@uri.request_uri))
	end

	#Basic web services Put command
	# * url = url to send the command to
	# * body = data to put in the body
	def put(path, body = nil)
		return request(uri, Net::HTTP::Put.new(@uri.request_uri), body)
	end

	#Sending the web services command
	# * url = url to send the command to
	# * req = command to send as Net::HTTP:<command> class
	# * body = data to put in the body
	def request(uri, request, body = nil)
		request.body = body unless body.nil?
		# request['Content-Type'] = DATA_TYPE
		# request['Accept'] = DATA_TYPE
		# request['X-ID'] = @xId
		http = Net::HTTP.new(@uri.host, @uri.port)
		begin
			@wsresponse = http.request(request)
			# print_response(@wsresponse)
			return @wsresponse
		rescue Timeout::Error => e 
			raise e.message
		end
	end
	
	def get_code
		@wsresponse.code
	end

	#Pretty print the web services response
	#* response = web service response to print
	# def print_response(response)
	# 	log "CODE = #{response.code}"
	# 	log "MESSAGE = #{response.message}"
	# 	response.each { |key, value| log "#{key} = #{value}\n"}
	# 	begin
	# 		log "BODY = "
	# 	  log body(response.body) 
	# 	rescue
	# 		log "[Empty]"
	# 	end
	# end
	
end
