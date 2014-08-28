feedUrl = "https://www.googleapis.com/calendar/v3/calendars/infilexfil.com_ij0amp5h2lir3tlf4sqfpb2geo@group.calendar.google.com/events?key=AIzaSyCJq9lb_y7fnomgGFsDFBRzngucKZL-Ri8"


$.get feedUrl, ((data)->
  for item in data.items
    console.log "#{item.summary} - #{item.start.dateTime} - #{item.end.dateTime} @ #{item.location}"
), "json"
