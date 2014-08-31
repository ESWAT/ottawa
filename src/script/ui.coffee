R = React.DOM

CalendarShell = React.createClass
  render: ->
    R.table
      id: "js-calendar"
      className: "calendar",

      R.thead
        id: "js-calendar__heading--days"

      R.tbody
        id: "js-calendar__weeks"

DayHeadings = React.createClass
  render: ->
    R.tr
      id: "js-calendar__heading--days"
      className: "calendar__heading--days",

      for dayHeading in @props.dayHeadings
        R.th null, "#{dayHeading}"

WeekGrid = React.createClass
  render: ->
    R.tbody
      id: "js-calendar__weeks"

      for days in [1..@props.monthLength + @props.startOffset] by 7

        WeekRow
          startOffset: if days < 8 then @props.startOffset else 0
          daysCounted: if days < 8 then days else days - @props.startOffset,
          monthLength: @props.monthLength

WeekRow = React.createClass
  render: ->
    R.tr
      id: "js-calendar__week"
      className: "calendar__week",
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

EventEntry = React.createClass
  render: ->
    R.h4
      className: "calendar__event"

      R.span null, "#{@props.startDate}"
      R.span null, "#{@props.summary}"
