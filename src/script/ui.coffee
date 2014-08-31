R = React.DOM

CalendarShell = React.createClass
  render: ->
    R.table
      id: "calendar",

      DayHeading
        dayHeadings: @props.dayHeadings

      for days in [1..@props.monthLength + @props.startOffset] by 7

        WeekRow
          startOffset: if days < 8 then @props.startOffset else 0
          daysCounted: if days < 8 then days else days - @props.startOffset,
          monthLength: @props.monthLength

DayHeading = React.createClass
  render: ->
    R.tr
      className: "calendar__heading--days",

      for dayHeading in @props.dayHeadings
        R.th null, "#{dayHeading}"

WeekRow = React.createClass
  render: ->
    R.tbody null,
      if @props.startOffset > 0
        for i in [1..@props.startOffset]
          DayCell
            date: "x"

      for date in [@props.daysCounted..(@props.daysCounted + 6 - @props.startOffset)]
        DayCell
          date: if date <= @props.monthLength then date else "x"

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
