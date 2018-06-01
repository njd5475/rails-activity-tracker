#= require ../models

@ActivityStop = React.createClass
  handleStop: ->
    # do nothing

  render: ->
    handleStop = @props.stop || this.handleStop
    `<button onClick={handleStop}>Stop</button>`
