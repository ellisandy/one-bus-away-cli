require "one_bus_away/version"
require 'rest-client'
require 'utilities'

module OneBusAway
  def self.api_key
    return File.read(ENV['HOME']+"/.one_bus_away")
  end
  
  def self.current_time
    response = RestClient.get("http://api.pugetsound.onebusaway.org/api/where/current-time.json?key=#{self.api_key}")
    json = JSON.parse(response)
    time = json["data"]["entry"]["time"]
    return time
  end
  
  def self.arrivals_and_departures_for_stop(stop, route, time_to_look_for)
    #
    response = RestClient.get("http://api.pugetsound.onebusaway.org/api/where/arrivals-and-departures-for-stop/1_#{stop}.json?key=#{self.api_key}&minutesAfter=#{time_to_look_for}")
    json = JSON.parse(response)
    arrivalsAndDepartures = json["data"]["entry"]["arrivalsAndDepartures"]
    
    @arrivalsAndDepartures2 = []
  
    arrivalsAndDepartures.each do |bus|
      if bus["routeShortName"] == route      
        @arrivalsAndDepartures2.push(Utilities.convert_time(bus["scheduledDepartureTime"].to_s))
      end
    end
    
    return @arrivalsAndDepartures2
  end
end
