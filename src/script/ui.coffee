R = React.DOM

CalendarShell = React.createClass
  loadCalendarFeed: ->
    $.get @props.url, ((data) ->
      if @isMounted()
        @setState
          eventsList: data.items
    ).bind(this)

  getInitialState: ->
    eventsList: []

  componentDidMount: ->
    @loadCalendarFeed()
    setInterval @loadCalendarFeed, @props.pollInterval


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
          R.th
            className: "calendar__heading-days-label",

            "#{dayHeading}"

WeekGrid = React.createClass
  getCurrentEvents: ->
    eventResults = []

    for currentEvent in @props.eventsList
      eventMonth = new Date(currentEvent.start.dateTime).getMonth()
      if eventMonth == @props.currentMonth
        eventResults.push currentEvent

    return eventResults

  render: ->
    currentEvents = @getCurrentEvents()

    R.tbody
      id: "js-calendar__weeks"

      for days in [1..@props.monthLength + @props.startOffset] by 7

        WeekRow
          currentEvents: currentEvents
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

      R.h3
        className: "calendar__day-label",

        @props.date

      if @props.eventsForDay
        for eventToday in @props.eventsForDay
          EventEntry
            eventInfo: eventToday
            onClick: @showEvent

EventEntry = React.createClass
  getInitialState: ->
    showEventDetails: false

  showEvent: ->
    @setState
      showEventDetails: true

  render: ->
    R.div
      className: "calendar__event",

      R.h4
        className: "calendar__event-label"
        onClick: @showEvent,

        R.span
          className: "calendar__event-time",
          "#{moment(@props.eventInfo.start.dateTime).format("H:mm")} "

        R.span
          className: "calendar__event-summary",
          "#{@props.eventInfo.summary}"

      EventDetails
        eventInfo: @props.eventInfo
        eventClass: if @state.showEventDetails == true then "visible" else "hidden"

EventDetails = React.createClass
  render: ->
    R.div
      className: "calendar__event-details #{@props.eventClass}",

      R.h2 null, "#{@props.eventInfo.summary}"
      R.p null, "#{moment(@props.eventInfo.start.dateTime).format("H:mm")} - \
        #{moment(@props.eventInfo.end.dateTime).format("H:mm")}"
