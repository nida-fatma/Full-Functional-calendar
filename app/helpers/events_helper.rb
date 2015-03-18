module EventsHelper
  def calendar_events
    @events = Event.all
    @hash = []
    @events.each do |e|
      case e.repeat
      when "Daily"
        repeat_event = Recurrence.new(:starts => e.start_time.to_date, :every => :day, :repeat => e.repeat_freq)
        @occurrences = repeat_event.events
      when "Monthly"
        repeat_event = Recurrence.new(:starts => e.start_time.to_date, :every => :month, :on => e.start_time.day, :repeat => e.repeat_freq)
        @occurrences = repeat_event.events
      when "Weekly"
        repeat_event = Recurrence.new(:starts => e.start_time.to_date, :every => :day, :repeat => e.repeat_freq)
        @occurrences = repeat_event.events
      else
        @occurrences = [e.start_time]
      end
      event_time = e.start_time.to_time
      @occurrences.each do |d|
        date_time = DateTime.new(d.year, d.month, d.day, event_time.hour, event_time.min, event_time.sec, event_time.zone)
        @hash << {
          :id => e.id,
          :title => e.title,
          :description => e.description,
          :start => date_time,
        }
      end
    end
    respond_to do |format|
     format.html # index.html.erb
     format.json { render json: @hash }
   end
 end
end