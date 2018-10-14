json.array! @events do |event|
  date_format = '%Y-%m-%dT%H:%M:%S'
  json.id event[:id]
  json.title event[:title]
  json.start event[:occurance_date].strftime(date_format)
  json.end (event[:occurance_date] + 1.hour).strftime(date_format)
  json.allDay false
  json.edit_url custom_edit_event_path(event)
end
