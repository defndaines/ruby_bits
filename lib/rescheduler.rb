#!/usr/bin/env ruby
require 'nexpose'
require 'yaml'
require 'time'

config = YAML.load_file('schedule.yml')

# Only parse out hours and minutes for duration.
match = /(\d*)h?(\d*)m?/.match(config[:window][:duration])
duration = match[2].to_i
duration += 60 * match[1].to_i
dur_in_sec = duration * 60

# A time alone will automatically parse into today that that time.
start = Time.parse(config[:window][:start])
if start < Time.now
  start = Time.now + 60
end

def needs_scan?(last, dur)
  case dur
  when 'week'
    # This isn't the same as once a week. It could slip over time.
    week = 60 * 60 * 24 * 7
    Time.now - last > week
  when 'month'
    Time.now.month != last.month
  else
    raise "Don't recognize period: #{dur}."
  end
end

config[:sites].each do |site|
  last = nsc.last_scan(site[:id])
  last_start = last.start_time
  next unless needs_scan?(last_start, site[:period])

  start_at = next_start(start)
  dur = remaining_duration(duration)

  site_config = Nexpose::Site.load(nsc, site[:id])
  schedule = site_config.schedules.first
  schedule = Nexpose::Schedule.new('monthly-date', 1, start_at) unless schedule
  schedule.start = start_at
  schedule.max_duration = dur
  schedule.repeater_type = 'continue'
  site_config.schedules[0] = schedule
  site_config.save(nsc)
end
