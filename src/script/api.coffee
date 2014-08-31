FEED_URL  = "https://www.googleapis.com/calendar/v3/calendars/" +
            "infilexfil.com_ij0amp5h2lir3tlf4sqfpb2geo@group.calendar.google.com" +
            "/events?key=AIzaSyCJq9lb_y7fnomgGFsDFBRzngucKZL-Ri8"

# Fetches events from calendar feed URL
fetchEvents = (month) ->
  eventsList = []

  $.ajax FEED_URL,
    success: (data, status, xhr) ->
      for item in data.items
        eventsList.push item

      getCurrentEvents(eventsList, month)

  return eventsList

getCurrentEvents = (eventsList, month) ->
  currentEvents = []

  for currentEvent in eventsList
    date = new Date(currentEvent.start.dateTime)
    console.log date.getMonth() + ":" + month
    if date.getMonth() == month
      currentEvents.push currentEvent

  console.log eventsList
  console.log currentEvents


# Start/stop periodicly fetching events
startFeedDaemon = ->
  feedDaemon = setInterval fetchEvents, 60*60*1000 # 1 hour

stopFeedDaemon = ->
  clearInterval feedDaemon
