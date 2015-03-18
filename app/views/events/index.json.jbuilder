hash =calendar_events 
json.array!(hash) do |event|
  json.extract! event, :id, :title, :description, :start
  json.url event_url(event, format: :html)
end