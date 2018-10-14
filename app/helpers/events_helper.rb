module EventsHelper
  def default_date(event)
    (event.occurance_date || DateTime.now).strftime('%Y-%m-%dT%H:%M')
  end

  def custom_edit_event_path(event)
    return edit_event_path(event[:id]) if current_user?(event[:user])

    event_path(event[:id])
  end
end
