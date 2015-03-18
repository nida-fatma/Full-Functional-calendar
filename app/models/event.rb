class Event < ActiveRecord::Base
 attr_accessor :duration
 validate :overlapping_events
 duration = Time.at(3000).utc.strftime("%H:%M:%S")

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
    (start_time + duration.hour.hours + duration.min.minutes + duration.sec.seconds).to_datetime
  end

  protected

  def overlapping_events
    if overlapping?
      errors[:base] << "This appointment overlaps with another one."
    end
  end
end
