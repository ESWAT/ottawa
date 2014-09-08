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
      id: "calendar"
      className: "calendar",

      DaysOfWeek
        dayHeadings: @props.dayHeadings

      DayGrid
        currentMonth: @props.currentMonth
        monthLength: @props.monthLength
        startOffset: @props.startOffset
        eventsList: @state.eventsList





DaysOfWeek = React.createClass
  render: ->
    R.thead
      className: "days-of-week",

      R.tr null,
        for dayHeading in @props.dayHeadings
          R.th
            className: "days-of-week--label",

            "#{dayHeading}"





DayGrid = React.createClass
  getCurrentEvents: ->
    eventResults = []

    for currentEvent in @props.eventsList
      eventMonth = new Date(currentEvent.start.dateTime).getMonth()
      if eventMonth == @props.currentMonth
        eventResults.push currentEvent

    return eventResults


  render: ->
    currentEvents = @getCurrentEvents()

    R.tr
      id: "day-grid"

      R.td
        colSpan: 7,

        for days in [1..@props.monthLength + @props.startOffset] by 7

          WeekRow
            rowHeight: 100 / Math.ceil(((@props.monthLength + @props.startOffset) / 7)) + "%"
            currentEvents: currentEvents
            startOffset: if days < 8 then @props.startOffset else 0
            daysCounted: if days < 8 then days else days - @props.startOffset,
            monthLength: @props.monthLength






WeekRow = React.createClass
  render: ->
    styleRules =
      height: @props.rowHeight

    R.div
      className: "week-wrap"
      style: styleRules,

      R.table
        className: "week",

        if @props.startOffset > 0
          for i in [1..@props.startOffset]
            DayCell
              date: ""
              specialClass: " day--outside"

        for date in [@props.daysCounted..(@props.daysCounted + 6 - @props.startOffset)]
          eventsForDay = []

          for currentEvent in @props.currentEvents
            eventDate = new Date(currentEvent.start.dateTime).getDate()

            if eventDate == date
              eventsForDay.push currentEvent

          # TODO: SO FUGLY
          specialClass = ""
          specialClass += if date <= @props.monthLength then "" else " day--outside"
          specialClass += if date == new Date().getDate() then " day--today" else ""

          DayCell
            date: if date <= @props.monthLength then date else ""
            eventsForDay: eventsForDay
            specialClass: specialClass





DayCell = React.createClass
  render: ->
    R.td
      className: "day#{@props.specialClass}",

      R.h3
        className: "day-label",

        @props.date

      if @props.eventsForDay
        for eventToday in @props.eventsForDay
          EventEntry
            eventInfo: eventToday
            onClick: @showEvent





EventEntry = React.createClass
  getInitialState: ->
    handledClick: false
    showEventDetails: false


  componentDidMount: ->
    window.addEventListener 'click', @hideEvent


  showEvent: (e) ->
    @setState
      handledClick: true
      showEventDetails: true


  hideEvent: (e) ->
    offsetName = e.target.offsetParent.className
    targetName = e.target.className
    compareName = "event-details"

    if offsetName != compareName && targetName != compareName
      # target is not event details window

      if @state.showEventDetails && @state.handledClick != true
        # window is showing but not from first activation
        @setState
          showEventDetails: false

      if @state.handledClick
        # no-longer first activation after first click
        @setState
          handledClick: false


  render: ->
    R.div
      className: "event",

      R.h4
        className: "event__label"
        onClick: @showEvent,

        R.span
          className: "event__time",
          "#{moment(@props.eventInfo.start.dateTime).format("H:mm")} "

        R.span
          className: "event__summary",
          "#{@props.eventInfo.summary}"

      if @state.showEventDetails

        EventDetails
          eventInfo: @props.eventInfo





EventDetails = React.createClass
  render: ->
    R.div
      className: "event-details",

      R.h2
        className: "event-details__title",

        "#{@props.eventInfo.summary}"

      R.p
        className: "event-details__date",

        "#{moment(@props.eventInfo.start.dateTime).format("H:mm")} - \
        #{moment(@props.eventInfo.end.dateTime).format("H:mm")}"

      R.p
        className: "event-details__description"

        "#{@props.eventInfo.description}"
