class OneBusAway
  # Class for establishing a connection to one bus away
  class Client
    attr_accessor :api_method, :api_key, :parameters
    attr_reader :body, :base_url, :url, :http_response, :http_status

    def initialize(options = {})
      @api_method = options[:api_method]
      @api_key = options[:api_key] || apply_local_api_key
      @parameters = options[:parameters]
      @base_url = 'api.pugetsound.onebusaway.org'
    end

    def valid?
      if api_method && api_key
        true
      else
        false
      end
    end

    def get
      if @url
        @http_response = RestClient.get(@url)
        @body = @http_response.body
        fail 'url not properly built'
      end
    end

    def build_url
      nil if valid?
      uri = URI::HTTP.build(
        host: @base_url,
        path: build_path,
        query: build_query
      )
      @url = uri.to_s
    end

    def build_path
      path = %w(api where)
      path.concat api_method
      path = path.join('/')
      @path = "/#{path}.json"
    end

    def build_query
      query = { key: @api_key }
      query.merge! @parameters if @parameters
      query.map { |k, v| "#{k}=#{v}" }.join('&')
    end

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
