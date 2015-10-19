class OneBusAway
  # Class for establishing a connection to one bus away
  class Client
    attr_accessor :api_method, :api_key, :parameters
    attr_reader :body, :http_request, :base_url

    def initialize(options = {})
      @api_method = options[:api_method]
      @api_key = options[:api_key] || 'otherkey'
      @parameters = options[:parameters]
      @base_url = 'http://api.pugetsound.onebusaway.org/api/where/'
    end

    def valid?
      if api_method && api_key && parameters
        true
      else
        false
      end
    end

    def get
      @body = 'somethign'
    end

    def build_url

    end

    def apply_local_api_key
      if File.exist? ENV['HOME'] + '/.one_bus_away'
        @api_key = File.read(ENV['HOME'] + '/.one_bus_away')
      else
        fail 'no API key provided. Please ensure you have your api key'\
          'installed in here: ~/.one_bus_away'
      end
    end
  end
end
