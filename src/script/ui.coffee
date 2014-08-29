R = React.DOM

CalendarShell = React.createClass
  render: ->
    R.table
      id: "calendar",

      DayHeading
        dayHeadings: @props.dayHeadings

DayHeading = React.createClass
  render: ->
    R.tr
      className: "calendar__heading--days",

      for dayHeading in @props.dayHeadings
        R.th null, "#{dayHeading}"

DayCell = React.createClass
  render: ->
    R.td null,
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
