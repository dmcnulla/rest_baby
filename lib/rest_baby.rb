=begin rdoc

== Authors

Dave McNulla

=end

require 'net/http'
require 'net/https'
require "rest_baby/version"

##
# RestBaby is a small rest client. It encapsulates some of the details for creating and using the rest service.
module RestBaby
	# Sends and receives data to a restful web service
	class Client

		##
		# Creates a new rest client
		#
		# * +url+ = url of the rest service
		# eg. http://myrestservice.com:80/time
		# * +headers+ = default headers to use.
		# eg. '{ \"Content-Type\" => \"application/json\"}'
		# can be multiple headers
		def initialize(url, headers = {})
			@uri = URI.parse(url)
			@headers = headers
			@user = nil
			@password = nil
		end

		##
		# Modifies the headers by merging new headers with current headers. 
		#
		# * +headers+ = new headers to merge with current headers
		def set_headers(headers)
			@headers = @headers.merge(headers)
		end

		##
		# Modifies the authentication for the rest client
		#
		# * +user+ = authorized username
		# * +password+ = password for the user
		def set_auth(user, password)
			new_url = "#{@uri.scheme}://#{user}:#{password}@#{@uri.host}:#{@uri.port}#{@uri.path}"
			@uri = URI.parse(new_url)
		end

		##
		# Basic web services Get command
		#
		# * +url+ = url to send the command to
		# * +headers+ = header parameters including authorization and Content-Type
		# The response from the rest server is returned
		def get(headers = {})
			return request(@uri, Net::HTTP::Get.new(@uri.request_uri), headers)
		end

		## 
		# Basic web services Post command
		# 
		# * +url+ = url to send the command to
		# * +body+ = data to put in the body
		# * +headers+ = header parameters including authorization and Content-Type
		# The response from the rest server is returned
		def post(body = nil, headers = {})
			return request(@uri, Net::HTTP::Post.new(@uri.request_uri), body, headers)
		end

		## 
		# Basic web services Delete command
		# 
		# * +url+ = url to send the command to
		# * +headers+ = header parameters including authorization and Content-Type
		# The response from the rest server is returned
		def delete(headers = {})
			return request(@uri, Net::HTTP::Delete.new(@uri.request_uri), headers)
		end

		## 
		# Basic web services Put command
		# 
		# * +url+ = url to send the command to
		# * +body+ = data to put in the body
		# * +headers+ = header parameters including authorization and Content-Type
		# The response from the rest server is returned
		def put(body = nil, headers = {})
			return request(@uri, Net::HTTP::Put.new(@uri.request_uri), body, headers)
		end

		## 
		# Sending the web services command
		#
		# * +url+ = url to send the command to
		# * +req+ = command to send as Net::HTTP:<command> class
		# * +body+ = data to put in the body
		# * +headers+ = header parameters including authorization and Content-Type
		# The response from the rest server is returned
		def request(uri, request, body = nil, headers)
			@headers.merge(headers).each { |key, value| request[key] = value }
			request.body = body unless body.nil?
			http = Net::HTTP.new(@uri.host, @uri.port)
			http.use_ssl = true if @uri.scheme == 'https'
			begin
				@wsresponse = http.request(request)
				# puts print_last_response
				return @wsresponse
			rescue Timeout::Error => e 
				raise e.message
			end
		end
		
		def get_code
			@wsresponse.code
		end

		## 
		# Pretty print the web services last response
		#
		# The nice looking output is returned as a string
		def print_last_response
			output = "CODE = #{@wsresponse.code}\n"
			output << "MESSAGE = #{@wsresponse.message}\n"
			@wsresponse.each { |key, value| output << "#{key} = #{value}\n"}
			begin
				output << "BODY = "
			  output << "#{@wsresponse.body}" 
			rescue
				output << "[Empty]"
			end
			return output
		end
		
	end
end
