require('date')
require('Contracts')

class OneBusAway
  # Useful cross class methods for sting modifications
  class Utilities
    include Contracts::Core
    C = Contracts
    def self.convert_time(time)
      stripped_time = strip_time(time)
      converted_date = DateTime.strptime(stripped_time, '%s')
      new_time = converted_date.to_time
      distance_of_time_in_hours_and_minutes(new_time, Time.now)
    end

    # Removes the last three characters from a string
    Contract String => String
    def strip_time(time)
      n = time.size
      time[0..n - 4]
    end

    # -> string, string
    # <- array of strings
    # Should return array of minutes from now
    # FIXME: Holy shit what the hell is this method???
    # Contract C::Num, C::Num => C::ArrayOf[C::Num]
    # def self.distance_of_time_in_hours_and_minutes(from_time, to_time)
    #   from_time = from_time.to_time if from_time.respond_to?(:to_time)
    #  to_time = to_time.to_time if to_time.respond_to?(:to_time)
    #  distance -= from_time
    #  minutes = (distance.abs / 60).round
    #  hours = minutes / 60
    #  minutes -= (hours * 60)

    #  words = distance <= 0 ? '' : '-'

    #  words << "#{hours} #{hours > 1 ? 'hours' : 'hour'} and " if hours > 0
    #  words << "#{minutes} #{minutes == 1 ? 'minute' : 'minutes'}"
    # end
  end
end
