#= require ../models

class ActivityStop extends React.Component
  handleStop: ->
    # do nothing

  render: ->
    handleStop = @props.stop || this.handleStop
    `<button onClick={handleStop}>Stop</button>`

@ActivityStop = ActivityStop
