feedUrl = "https://www.googleapis.com/calendar/v3/calendars/infilexfil.com_ij0amp5h2lir3tlf4sqfpb2geo@group.calendar.google.com/events?key=AIzaSyCJq9lb_y7fnomgGFsDFBRzngucKZL-Ri8"

events = $.get feedUrl, ->
  console.log events
