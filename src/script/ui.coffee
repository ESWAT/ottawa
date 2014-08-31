R = React.DOM

CalendarShell = React.createClass
  getInitialState: ->
    eventsList: []

  componentDidMount: ->
    $.get @props.url, ((data) ->
      if @isMounted()
        @setState
          eventsList: data.items
    ).bind(this)

  render: ->
    R.table
      id: "js-calendar"
      className: "calendar",

      DayHeadings
        dayHeadings: @props.dayHeadings

      WeekGrid
        currentMonth: @props.currentMonth
        monthLength: @props.monthLength
        startOffset: @props.startOffset
        eventsList: @state.eventsList

DayHeadings = React.createClass
  render: ->
    R.thead
      id: "js-calendar__heading--days"
      className: "calendar__heading--days",

      R.tr null,
        for dayHeading in @props.dayHeadings
          R.th null, "#{dayHeading}"

WeekGrid = React.createClass
  getInitialState: ->
    currentEvents: []

  render: ->
    for currentEvent in @props.eventsList
      eventMonth = new Date(currentEvent.start.dateTime).getMonth()
      if eventMonth == @props.currentMonth
        @state.currentEvents.push currentEvent

    R.tbody
      id: "js-calendar__weeks"


      for days in [1..@props.monthLength + @props.startOffset] by 7

        WeekRow
          currentEvents: @state.currentEvents
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
        eventsForDay = []

        for currentEvent in @props.currentEvents
          eventDate = new Date(currentEvent.start.dateTime).getDate()

          if eventDate == date
            eventsForDay.push currentEvent

        DayCell
          date: if date <= @props.monthLength then date else "x"
          eventsForDay: eventsForDay


DayCell = React.createClass
  render: ->
    R.td
      className: "calendar__day"

      R.h3 null, @props.date

      if @props.eventsForDay
        for eventToday in @props.eventsForDay
          EventEntry
            startDate: eventToday.start.dateTime
            summary: eventToday.summary

EventEntry = React.createClass
  render: ->
    R.h4
      className: "calendar__event"

      R.span null, "#{@props.startDate}"
      R.span null, "#{@props.summary}"
