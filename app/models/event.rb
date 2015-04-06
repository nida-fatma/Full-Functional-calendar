class Event < ActiveRecord::Base
attr_accessor :repeat_week_days

validate :overlapping_events

scope :overlapping, ->(a) {
	where(%q{ (start_time, (start_time + duration)) OVERLAPS (?, ?) }, a.start_time, a.end_time)
	.where(%q{ id != ? }, a.id)
}

def find_overlapping
	self.class.overlapping(self)
end

def overlapping?
	self.class.overlapping(self).count > 0
end

def end_time
	(start_time + 2000.seconds).to_datetime
end


def self.calendar_events(event_params)
	event = Event.new(event_params)
	@hash = []
	case event.repeat
	when "daily"
		repeat_event = recurrence.new(:starts => event.start_time.to_date, :every => :day, :repeat => event.repeat_freq)
		@occurrences = repeat_event.events
	when "monthly"
		repeat_event = recurrence.new(:starts => event.start_time.to_date, :every => :month, :on => event.start_time.day, :repeat => event.repeat_freq, :shift => true)
		@occurrences = repeat_event.events
	when "weekly"
		repeat_event = recurrence.new(:starts => event.start_time.to_date, :every => :week, :on => event_params['repeat_week_days'], :repeat => event.repeat_freq)
		@occurrences = repeat_event.events
	else
		@occurrences = [event.start_time]
	end
	event_time = event.start_time.to_time
	@occurrences.each do |d|
		date_time = DateTime.new(d.year, d.month, d.day, event_time.hour, event_time.min, event_time.sec, event_time.zone)
		@hash << {
			:id => event.id,
			:title => event.title,
			:description => event.description,
			:start_time => date_time,
			:duration => event.duration,
		}
	end
	return @hash
end

protected

def overlapping_events
	if overlapping?
		errors[:base] << "this appointment overlaps with another one."
	end
end 
end
