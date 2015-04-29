require("date")

class Utilities
  def self.convert_time(time)
    stripped_time = self.strip_time(time)
    
    converted_date = DateTime.strptime(stripped_time,"%s")
    
    new_time = converted_date.to_time#.strftime "%I:%M %P"
    distance_of_time_in_hours_and_minutes(new_time, Time.now)
  end
  
  def self.strip_time(time_to_strip)
    n = time_to_strip.size
    stripped_time = time_to_strip[0..n-4]
    return stripped_time
  
  end
  
  def self.distance_of_time_in_hours_and_minutes(from_time, to_time)
    from_time = from_time.to_time if from_time.respond_to?(:to_time)
    to_time = to_time.to_time if to_time.respond_to?(:to_time)
    dist = to_time - from_time
    minutes = (dist.abs / 60).round
    hours = minutes / 60
    minutes = minutes - (hours * 60)

    words = dist <= 0 ? '' : '-'

    words << "#{hours} #{hours > 1 ? 'hours' : 'hour' } and " if hours > 0
    words << "#{minutes} #{minutes == 1 ? 'minute' : 'minutes' }"
  end
end