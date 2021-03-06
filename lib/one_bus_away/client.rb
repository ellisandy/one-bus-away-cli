require 'rest-client'
require 'recursive-open-struct'

class OneBusAway
  # Class for establishing a connection to one bus away
  class Client
    attr_accessor :api_method, :api_key, :parameters
    attr_reader :base_url, :url, :http_response

    def initialize(options = {})
      @api_method = options[:api_method]
      @api_key = options[:api_key] || apply_local_api_key
      @parameters = options[:parameters]
      @base_url = 'api.pugetsound.onebusaway.org'
    end

    # Verifies that @api_method and @api_key are set
    def valid?
      if api_method && api_key
        true
      else
        false
      end
    end

    # Provided that @url is set, HTTP get @url
    def get
      if @url
        response = RestClient.get(@url)
        json = JSON.parse(response)
        @http_response = RecursiveOpenStruct.new(
          json, recurse_over_arrays: true
        )
      else
        fail 'url is not properly built'
      end
    end

    # Builds a valid url, then sets this string to @url
    def build_url
      @url = URI::HTTP.build(
        host: @base_url,
        path: build_path,
        query: build_query
      ).to_s if valid?
    end

    # Builds the path for utilization in #build_url
    def build_path
      path = %w(api where)
      path.concat api_method
      path = path.join('/')
      @path = "/#{path}.json"
    end

    # Build query for utilization in #build_url
    def build_query
      query = { key: @api_key }
      query.merge! @parameters if @parameters
      query.map { |k, v| "#{k}=#{v}" }.join('&')
    end

    # Applies ~/.one_bus_away to @api if the file exists
    # otherwise, it fails.
    def apply_local_api_key
      if File.exist? ENV['HOME'] + '/.one_bus_away'
        file = File.read(ENV['HOME'] + '/.one_bus_away')
        @api_key = file.chomp
      else
        fail 'no API key provided. Please ensure you have your api key'\
          'installed in here: ~/.one_bus_away'
      end
    end
  end
end
