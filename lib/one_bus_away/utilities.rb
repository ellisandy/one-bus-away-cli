require 'date'
require 'active_support'
require 'action_view'

include ActionView::Helpers::DateHelper

class OneBusAway
  # Useful cross class methods for sting modifications
  class Utilities
    # Converts time into a consumable format
    def self.convert_time(time)
      obj = OneBusAway::Utilities.new
      stripped_time = obj.strip_time(time)
      converted_date = DateTime.strptime(stripped_time, '%s')
      distance_of_time_in_words_to_now(converted_date.to_time)
    end

    # Removes the last three characters from a string
    def strip_time(time)
      time = time.to_s
      n = time.size
      time[0..n - 4]
    end
  end
end
