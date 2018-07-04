#= require moment

class ActivityTime extends React.Component
  render: ->
    time = ""
    if @props.time
      time = moment(@props.time).format("hh:mm")
    `<span>{time}</span>`

@ActivityTime = ActivityTime
