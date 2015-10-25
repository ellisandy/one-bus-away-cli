require_relative 'one_bus_away/version'
require_relative 'one_bus_away/utilities'
require_relative 'one_bus_away/client'

# Main class
# defines the way to interact with everything
class OneBusAway
  attr_accessor :api_method, :parameters
  attr_reader :client, :data, :http_response

  def initialize(options = {})
    @api_method = options[:api_method]
    @parameters = options[:parameters]
  end

  # Returns the current time from the One Bus Away System
  def current_time
    @client = OneBusAway::Client.new(
      api_method: ['current-time']
    )
    call_api
  end

  # get arrivales and departunes for a stop with one arguement
  def arrivals_and_departures_for_stop(stop)
    @client = OneBusAway::Client.new(
      api_method: ['arrivals-and-departures-for-stop', "1_#{stop}"]
    )
    call_api
  end

  # Assigns the http data to the @data instance variable
  def assign_data
    @data = client.http_response.data
  end

  # Short hand for building the URL, calling the API, and assigning the data
  # to @data
  def call_api
    @client.build_url
    @client.get
    assign_data
  end

  # filter the route by a specific route
  def filter_by_route
    array = []
    data.entry.arrivalsAndDepartures.each do |bus|
      time = OneBusAway::Utilities.convert_time bus.scheduledDepartureTime
      array << { bus.routeShortName => time }
    end
    array
  end
end
