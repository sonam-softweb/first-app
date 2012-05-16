# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

## LEE 061111
def distance_of_time_in_hours_and_minutes(from_time, to_time)
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
## /LEE 061111

end
