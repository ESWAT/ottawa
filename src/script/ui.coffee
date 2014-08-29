R = React.DOM

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
