# rest_baby.rb
# @author Dave McNulla of ResMed
# Originated: 2011
# This library was written to simplify communications with rest services.

require 'net/http'
require 'net/https'
require 'json'
require 'nokogiri'
require 'rest_baby/version'

# RestBaby is a small rest client. It encapsulates some of the details for
# creating and using the rest service.
# @private
module RestBaby
  # Sends and receives data to a restful web service
  class Client
    PARAM_STARTER = '?'
    PARAM_SEPARATOR = '&'

    # The WebService Response from the last call
    attr_reader :wsresponse
    # The user (for authentication)
    attr_reader :user
    # The password for the user (for authentication)
    attr_reader :password
    # Response Code
    attr_reader :code

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
      @verbose = (ENV['DEBUG_HTTP'] != 'false')
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
    def add_headers(headers)
      @headers = @headers.merge(headers)
    end

    # Basic web services Get command
    #
    # @param headers [Hash] header parameters including authorization
    #   and Content-Type
    # @param path [String] Path of service to send the command to
    # @param parameters [Hash] query string that added as part of the URL
    # @return The response from the rest server is returned
    def get(headers = {}, path = '', parameters = {})
      full_path = [path, URI.encode_www_form(parameters)].join(PARAM_STARTER)
      uri = URI.parse("#{@url}#{full_path}")
      request = Net::HTTP::Get.new(uri.request_uri)
      request.body = nil
      send_request(uri, request, headers)
    end

    # Basic web services Post command
    #
    # @param path [String] Path of service to send the command to
    # @param body [Any type of string] Data to put in the
    #   body such as json or xml
    # @param headers [Hash] header parameters including authorization
    #   and Content-Type
    # @return The response from the rest server is returned
    def post(body = nil, headers = {}, path = '')
      uri = URI.parse("#{@url}#{path}")
      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = body unless body.nil?
      send_request(uri, request, headers)
    end

    # Basic web services Delete command
    #
    # @param path [String] Path of service to send the command to
    # @param headers [Hash] header parameters including
    #   authorization and Content-Type
    # @return The response from the rest server is returned
    def delete(headers = {}, path = '', parameters = {})
      full_path = [path, URI.encode_www_form(parameters)].join(PARAM_STARTER)
      uri = URI.parse("#{@url}#{full_path}")
      request = Net::HTTP::Delete.new(uri.request_uri)
      request.body = nil
      send_request(uri, request, headers)
    end

    # Basic web services Put command
    #
    # @param path [String] Path of service to send the command to
    # @param body [String] data to put in the body
    # @param headers [Hash] header parameters including authorization
    #   and Content-Type
    # @return Response from the rest server is returned
    def put(body = nil, headers = {}, path = '')
      uri = URI.parse("#{@url}#{path}")
      request = Net::HTTP::Put.new(uri.request_uri)
      request.body = body unless body.nil?
      send_request(uri, request, headers)
    end

    private

    def send_request(uri, request, headers)
      @headers.merge(headers).each { |key, value| request[key] = value }
      request.basic_auth(@user, @password) unless @user.nil?
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'
      print_request(request, uri)
      @wsresponse = http.request(request)
      print_response(@wsresponse)
      @wsresponse
    end

    def print_request(request, uri)
      return nil unless @verbose
      query = ((uri.query == '') ? '' : "?#{uri.query}")
      puts ">> REQUEST\n"\
        ">  URL: #{uri.scheme}://#{uri.host}:#{uri.port}#{uri.path}#{query}\n"\
        ">  Headers:\n"\
        "#{header_text(request, '> ')}\n"\
        ">  BODY =\n"\
        ">  BODY =\n#{body_text(request['Content-Type'], request.body)}"
    end

    def print_response(response)
      return nil unless @verbose
      puts "<< RESPONSE\n"\
         "< CODE = #{response.code}\n"\
         "< MESSAGE = #{response.message}\n"\
         "#{header_text(response, ' <')}\n"\
         "< BODY =\n#{body_text(response['Content-Type'], response.body)}"
    end

    def header_text(message, pointer)
      headers = ''
      message.each { |key, value| headers << "#{pointer} #{key} = #{value}\n" }
      headers
    end

    def body_text(type, response_body)
      return '[Empty]' if response_body.nil?
      case type
      when 'application/json'
        pretty(response_body)
      when 'application/xml'
        pretty_xml(response_body)
      else
        "#{response_body}\n<"
      end
    end

    def pretty_json(json)
      json = JSON(json) unless json.class == Hash
      JSON.pretty_generate(json)
    end

    def pretty_xml(xml)
      doc = Nokogiri.XML(xml) { |config| config.default_xml.noblanks }
      doc.to_xml(indent: 2)
    end
  end
end
