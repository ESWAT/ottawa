DAY_LABELS    = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
MONTH_LABELS  = ["January", "February", "March", "April",
                "May", "June", "July", "August",
                "September", "October", "November", "December"]
DAYS_IN_MONTH = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
FEED_URL  = "https://www.googleapis.com/calendar/v3/calendars/" +
            "infilexfil.com_ij0amp5h2lir3tlf4sqfpb2geo@group.calendar.google.com" +
            "/events?key=AIzaSyCJq9lb_y7fnomgGFsDFBRzngucKZL-Ri8"

Calendar = (month, year) ->
  @month = (if (isNaN(month) or not month?) then new Date().getMonth() else month)
  @year = (if (isNaN(year) or not year?) then new Date().getFullYear() else year)

  React.renderComponent MonthHeading(
    monthLabel: MONTH_LABELS[@month]),
    document.getElementById("month-heading")

  React.renderComponent CalendarShell(
    currentMonth: @month
    dayHeadings: DAY_LABELS
    monthLength: DAYS_IN_MONTH[@month]
    startOffset: new Date(@year, @month, 1).getDay()
    url: FEED_URL
    pollInterval: 12 * 60 * 60 * 1000), # 12 hours
    document.getElementById("calendar")
