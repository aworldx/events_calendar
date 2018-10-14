$(document).on 'turbolinks:load', ->
  query = window.location.search.substring(1)
  $('#calendar').fullCalendar
    header: { center: 'month,agendaWeek,agendaDay' },
    events: (start, end, timezone, callback) ->
      $.ajax
        url: "/events/events_data?#{query}"
        dataType: 'json'
        data:
          period_from: start.format()
          period_to: end.format()
        success: (doc) ->
          events = []
          $(doc).each ->
            events.push
              title: $(this).attr('title')
              start: $(this).attr('start')
              edit_url: $(this).attr('edit_url')
            return
          callback events
          return
      return
    editable: true
    eventStartEditable: false
    timeFormat: 'H(:mm)'
    eventClick: (event, jsEvent, view) ->
      window.location.href = event.edit_url
      return
