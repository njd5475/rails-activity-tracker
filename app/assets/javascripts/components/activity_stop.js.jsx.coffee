#= require ../models
#= require react-transition-group/src/index

class ActivityStop extends React.Component
  constructor: (props) ->
    super props
    @state = displayState: 'words'
    @rotate()

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

    handleStop = @props.stop || this.handleStop

    `<button onClick={handleStop}>
      <Transition in={"loader"} timeout={300}>
        <div className="loader spin" />
      </Transition>
      {btnDisplay}
    </button>`

@ActivityStop = ActivityStop
