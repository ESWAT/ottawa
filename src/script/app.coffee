# CONSTANTS
FEED_URL      = "https://www.googleapis.com/calendar/v3/calendars/" +
                "infilexfil.com_ij0amp5h2lir3tlf4sqfpb2geo@group.calendar.google.com" +
                "/events?key = AIzaSyCJq9lb_y7fnomgGFsDFBRzngucKZL-Ri8"
DAY_LABELS    = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
MONTH_LABELS  = ["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"]
DAYS_IN_MONTH = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

currentDate = new Date()

# React classes
R = React.DOM

DayEntry = React.createClass
  render: ->
    R.div null,
      R.h3 null, "24"
      EventEntry
        summary: @props.summary
        startDate: @props.startDate


EventEntry = React.createClass
  render: ->
    R.h4 null,
      R.span null, "#{@props.startDate}"
      R.span null, "Entry: + #{@props.summary}"

Calendar = (month, year) ->
  @month = (if (isNaN(month) or not month?) then currentDate.getMonth() else month)
  @year = (if (isNaN(year) or not year?) then currentDate.getFullYear() else year)

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

$ ->
  fetchEvents()
