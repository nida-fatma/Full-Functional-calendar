class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
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

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :start_time, :repeat, :repeat_freq)
    end
  end
