#= require ../models

class ActivityStop extends React.Component
  constructor: (props) ->
    super props
    @state = displayState: 'words'

  rotate: =>
    if @state.displayState == 'spinner'
      @setState displayState: 'words'
    else
      @setState displayState: 'spinner'

    setTimeout @rotate, 1000

  handleStop: =>
    # do nothing

  render: =>
    btnDisplay = "St" if @state.displayState == 'spinner'
    btnDisplay = "Stop" if @state.displayState == 'words'

    handleStop = @props.stop or this.handleStop

    `<button onClick={handleStop}>
      <div className="loader spin" />
      {btnDisplay}
    </button>`

@ActivityStop = ActivityStop
