require_relative 'one_bus_away/version'
require_relative 'one_bus_away/utilities'
require_relative 'one_bus_away/client'
require 'rest-client'
require 'contracts'
require 'geocoder'

# Main class
# defines the way to interact with everything
class OneBusAway
  include Contracts::Core
  # Shortcut for utilizing Contracts
  C = Contracts

  # Contract String => String
  def initialize
  end

  def self.get_location(loc)
    geo = Geocoder.search("#{loc} seattle")
    lat = geo[0].latitude
    lon = geo[0].longitude
    return lat, lon
  end
end
