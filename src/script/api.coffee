FEED_URL  = "https://www.googleapis.com/calendar/v3/calendars/" +
            "infilexfil.com_ij0amp5h2lir3tlf4sqfpb2geo@group.calendar.google.com" +
            "/events?key=AIzaSyCJq9lb_y7fnomgGFsDFBRzngucKZL-Ri8"

# Fetches events from calendar feed URL
fetchEvents = ->
  $.get FEED_URL, ((data)->
    currentDate = new Date()
    for item in data.items
      React.renderComponent DayEntry(
        summary: item.summary,
        startDate: item.start.dateTime),
        document.body
  ), "json"

# Start/stop periodicly fetching events
startFeedDaemon = ->
  feedDaemon = setInterval fetchEvents, 60*60*1000 # 1 hour

stopFeedDaemon = ->
  clearInterval feedDaemon
