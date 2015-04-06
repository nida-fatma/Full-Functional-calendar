json.array!(@events) do |event|
  json.extract! event, :id, :title, :description
  json.url event_url(event, format: :html)
  json.start event.start_time
end