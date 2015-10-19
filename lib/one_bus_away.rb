require_relative 'one_bus_away/version'
require 'rest-client'
require 'utilities'
require 'contracts'

# Main class
# defines the way to interact with everything
class OneBusAway
  include Contracts::Core
  C = Contracts

  Contract String => String
  def initialize(api_key)
    @api_key = api_key
  end

  # FIXME: remove RestClient.get from here, and move it to another method
  Contract String
  def current_time
    oba_client = OneBusAway::Client
    response = RestClient.get(
      'http://api.pugetsound.onebusaway.org/api/where/'\
      "current-time.json?key=#{@api_key}"
    )
    json = JSON.parse(response)
    time = json['data']['entry']['time']
    time.to_s
  end

  # Contract C::Num, C::Or[C::Num, String], C::Num => C::ArrayOf[C::Any]
  def arrivals_and_departures_for_stop(stop, route, time_to_look_for)
    if valid_stop?(stop) && valid_route?(route)
      response = RestClient.get(
        'http://api.pugetsound.onebusaway.org/api/where/'\
        "arrivals-and-departures-for-stop/1_#{stop}.json?"\
        "key=#{@api_key}&minutesAfter=#{time_to_look_for}"
      )
      json = JSON.parse(response)
      arrivals_and_departures = json['data']['entry']['arrivalsAndDepartures']

      outputs = []

      arrivals_and_departures.each do |bus|
        next unless bus['routeShortName'] == route
        outputs.push(
          Utilities.convert_time(bus['scheduledDepartureTime'].to_s)
        )
      end
      outputs

    else
      fail 'Either your route or stop is invalid.'
    end
  end

  # Contract C::Num => C::Bool
  def valid_stop?(stop_number)
    response = RestClient.get(
      'http://api.pugetsound.onebusaway.org/api/where/'\
      "stop-ids-for-agency/1.json?key=#{@api_key}"
    )
    json = JSON.parse(response)

    if json['code'] == 200
      json['data']['list'].include? "1_#{stop_number}"
    else
      fail "OneBusAway API HTTP response error #{json['code']}"
    end
  end

  # Contract C::Or[C::Num, String] => C::Bool
  def valid_route?(route_name)
    response = RestClient.get(
      'http://api.pugetsound.onebusaway.org/api/where/'\
      "routes-for-agency/1.json?key=#{@api_key}"
    )
    json = JSON.parse(response)

    if json['code'] == 200
      array = []
      json['data']['list'].map { |x| array.push x['shortName'] }

      array.include? route_name.to_s
    else
      fail "OneBusAway API HTTP response error #{json['code']}"
    end
  end
end
