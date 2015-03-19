class Event < ActiveRecord::Base
  attr_accessor :repeat_week_days

  def set_repeat_day
  	binding.pry
    self.repeat = self.repeat + self.repeat_week_days
  end
 # validate :overlapping_events

 #  scope :overlapping, ->(a) {
 #     where(%q{ (start_time, (start_time + duration.seconds).to_datetime) OVERLAPS (?, ?) }, a.start_time, a.end_time)
 #    .where(%q{ id != ? }, a.id)
 #  }

 #  def find_overlapping
 #    self.class.overlapping(self)
 #  end

 #  def overlapping?
 #    self.class.overlapping(self).count > 0
 #  end

 #  def end_time
 #    (start_time + 2000.seconds).to_datetime
 #  end

 #  protected

 #  def overlapping_events
 #    if overlapping?
 #      errors[:base] << "This appointment overlaps with another one."
 #    end
 #  end
end
