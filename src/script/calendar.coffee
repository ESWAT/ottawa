DAY_LABELS    = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
MONTH_LABELS  = ["January", "February", "March", "April",
                "May", "June", "July", "August",
                "September", "October", "November", "December"]
DAYS_IN_MONTH = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

currentDate = new Date()

Calendar = (month, year) ->
  @month = (if (isNaN(month) or not month?) then currentDate.getMonth() else month)
  @year = (if (isNaN(year) or not year?) then currentDate.getFullYear() else year)