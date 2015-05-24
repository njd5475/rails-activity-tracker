#= require moment

@ActivityTime = React.createClass
  render: ->
    time = ""
    if @props.time
      time = moment(@props.time).format("hh:mm")
    `<span>{time}</span>`