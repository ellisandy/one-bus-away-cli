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

  def get_location(loc)
    geo = Geocoder.search("#{loc} seattle")
    lat,lon = geo[0].latitude, geo[0].longitude
  end
end
