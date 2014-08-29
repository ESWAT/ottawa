R = React.DOM

DayRow = React.createClass
  render: ->
    R.th null,
      R.tr null,
        for day in @props.days
          R.td null, "#{day}"


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
