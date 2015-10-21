require_relative 'one_bus_away/version'
require_relative 'one_bus_away/utilities'
require_relative 'one_bus_away/client'
require 'rest-client'
require 'contracts'

# Main class
# defines the way to interact with everything
class OneBusAway
  include Contracts::Core
  # Shortcut for utilizing Contracts
  C = Contracts

  attr_accessor :api_method, :input, :parameters
  attr_reader :client, :output

  # Contract String => String
  # def initialize
  # end

  def current_time
    @client = OneBusAway::Client.new
    # @client.build_url
    @client.get
  end
end
