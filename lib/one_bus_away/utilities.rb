require('date')
require('Contracts')

class OneBusAway
  # Useful cross class methods for sting modifications
  class Utilities
    include Contracts::Core
    # Short cut for access to Contracts
    C = Contracts

    Contract String => C::Any
    # Converts time into a consumable format
    def self.convert_time(time)
      obj = OneBusAway::Utilities.new
      stripped_time = obj.strip_time(time)
      converted_date = DateTime.strptime(stripped_time, '%s')
      converted_date.to_time
    end

    Contract String => String
    # Removes the last three characters from a string
    def strip_time(time)
      n = time.size
      time[0..n - 4]
    end
  end
end
