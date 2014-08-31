R = React.DOM

CalendarShell = React.createClass
  render: ->
    R.table
      id: "calendar",

      DayHeading
        dayHeadings: @props.dayHeadings

      for days in [1..@props.monthLength] by 7
        WeekRow
          daysCounted: days

DayHeading = React.createClass
  render: ->
    R.tr
      className: "calendar__heading--days",

      for dayHeading in @props.dayHeadings
        R.th null, "#{dayHeading}"

WeekRow = React.createClass
  render: ->
    R.tbody null,
      for date in [@props.daysCounted..(@props.daysCounted+7)]
        DayCell
          date: date

DayCell = React.createClass
  render: ->
    R.td
      className: "calendar__day"

      R.h3 null, @props.date

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
