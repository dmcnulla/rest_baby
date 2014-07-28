# rest_baby.rb
# @author Dave McNulla of ResMed
# Originated: 2011
# This library was written to simplify communications with rest services.

require 'net/http'
require 'net/https'
require 'json'
require 'nokogiri'
require 'rest_baby/version'

# RestBaby is a small rest client. It encapsulates some of the details for creating and using the rest service.
# @private
module RestBaby
	# Sends and receives data to a restful web service
	class Client
			PARAMETER_STARTER = "?"
			PARAMETER_SEPARATOR = "&"

		# The WebService Response from the last call
		attr_reader :wsresponse
		# The user (for authentication)
		attr_reader :user
		# The password for the user (for authentication)
		attr_reader  :password

		# Creates a new rest client
		#
		# @param url [String] url of the rest service
		# eg. http://myrestservice.com:80/time
		# @param headers [Hash] default headers to use.
		# eg. '{ \"Content-Type\" => \"application/json\"}'
		# Can be multiple headers separated by commas inside the brackets.
		def initialize(url, headers = {}, user = nil, password = nil)
			@url = url
			@headers = headers
			@user = user
			@password = password

			if ENV["DEBUG_HTTP"].nil?
				@verbose = true
			else
				@verbose = ENV["DEBUG_HTTP"].downcase=='true' ? true : false
			end
		end

		# Adds user/password to the rest client
		#
		# @param user [String] user that has authorization
		# @param password [String] authorized user's password
		def set_auth(user, password)
			@user = user
			@password = password
		end

		# Modifies the headers by merging new headers with current headers. 
		#
		# @param headers [Hash] new headers to merge with current headers
		def set_headers(headers)
			@headers = @headers.merge(headers)
		end

		# Basic web services Get command
		#
		# @param headers [Hash] header parameters including authorization and Content-Type
		# @param path [String] Path of service to send the command to
		# @param parameters [Hash] query string that added as part of the URL
		# @return The response from the rest server is returned
		def get(headers = {}, path = '', parameters = {})
			full_path = path_with_params(path, parameters)
			uri = URI.parse("#{@url}#{full_path}")
			return request(uri, Net::HTTP::Get.new(uri.request_uri), nil, headers)
		end
 
		# Basic web services Post command
		# 
		# @param path [String] Path of service to send the command to
		# @param body [Any type of string] Data to put in the body such as json or xml
		# @param headers [Hash] header parameters including authorization and Content-Type
		# @return The response from the rest server is returned
		def post(body = nil, headers = {}, path = '')
			uri = URI.parse("#{@url}#{path}")
			return request(uri, Net::HTTP::Post.new(uri.request_uri), body, headers)
		end
 
		# Basic web services Delete command
		# 
		# @param path [String] Path of service to send the command to
		# @param headers [Hash] header parameters including authorization and Content-Type
		# @return The response from the rest server is returned
		def delete(headers = {}, path = '')
			uri = URI.parse("#{@url}#{path}")
			return request(uri, Net::HTTP::Delete.new(uri.request_uri), headers)
		end
 
		# Basic web services Put command
		# 
		# @param path [String] Path of service to send the command to
		# @param body [String] data to put in the body
		# @param headers [Hash] header parameters including authorization and Content-Type
		# @return Response from the rest server is returned
		def put(body = nil, headers = {}, path = '')
			uri = URI.parse("#{@url}#{path}")
			return request(uri, Net::HTTP::Put.new(uri.request_uri), body, headers)
		end

		# Get the code from the last call
		#
		# @return the http code such as 200, 301, 403, 404, or 500
		def get_code
			@wsresponse.code
		end
 
		# Set verbose on or off
		#
		# @param on [Boolean] True=verbose, False=Not verbose
		def set_verbose(on = true)
			@verbose = on
		end

		private

		def path_with_params(path, params)
		   encoded_params = URI.encode_www_form(params)
		   [path, encoded_params].join("?")
		end

		# Sending the web services command
		#
		# @param uri [URI] Uri to send the command to
		# @param request [HTTP Request] command to send as Net::HTTP:<command> class; get, post, put, delete.
		# @param body [String] data to put in the body
		# @param headers [Hash] header parameters including authorization and Content-Type
		# @return The response from the rest server is returned
		def request(uri, request, body = nil, headers = {})
			@headers.merge(headers).each { |key, value| request[key] = value }
			request.basic_auth(@user, @password) unless @user.nil?
			request.body = body unless body.nil?
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true if uri.scheme == 'https'
			print_request(request, http, uri)
			begin
				@wsresponse = http.request(request)
				print_response(@wsresponse)
				return @wsresponse
			rescue Timeout::Error => e 
				raise e.message
			end
		end
		
		# Print the Request 
		def print_request(request, http, uri)
			if uri.query==''
				query = ''
			else
				query = "?#{uri.query}"
			end
			if @verbose
				puts ">> REQUEST"
	        	puts ">  URL: #{uri.scheme}://#{uri.host}:#{uri.port}#{uri.path}#{query}"
	        	puts ">  Headers: "
	        	request.each { |key, value| puts " >  #{key}: #{value}" }
	        	# puts "> Basic_Auth #{request.basic_auth}"
		        puts ">  BODY = "
		        if request.body.nil?
		            puts "[Empty]"
	            elsif request['Content-Type']=='application/json'
		            jj JSON(request.body) 
		        elsif request['Content-Type']=='text/csv'
		            puts request.body
		        elsif request['Content-Type']=='application/xml'
		            puts pretty_xml(request.body)
		        else
		            puts request.body
		        end
		    end
	    end
 
		# Pretty print the web services last response
		def print_response(response)
			if @verbose
		        puts "<< RESPONSE"
		        puts " < CODE = #{response.code}"
		        puts " < MESSAGE = #{response.message}"
		        response.each { |key, value| puts " < #{key} = #{value}\n"}
		        puts " < BODY = "
		        if response.header['Content-Type']=='application/json'
		            jj JSON(response.body) 
		        elsif response.header['Content-Type']=='text/csv'
		            puts response.body
		        elsif response.header['Content-Type']=='application/xml'
		            puts pretty_xml(body)
		        elsif response.body.nil?
		            puts "[Empty]"
		        else 
		            puts "#{response.body}\n<"
		        end
		    end
	    end

	    def pretty_xml(xml)
	    	doc = Nokogiri.XML(xml) do |config|
  				config.default_xml.noblanks
  			end
  			return doc.to_xml(:indent => 2)
  		end
	end
end
