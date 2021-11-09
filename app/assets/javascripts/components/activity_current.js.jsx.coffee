#= require countdownjs

class ActivityCurrent extends React.Component
  constructor: (props) ->
    super props
    @state = count: 0

  componentDidMount: ->
    @setState interval: setInterval @updateCount, 1000

  componentWillUnmount: =>
    clearInterval(@state.interval)

  updateCount: =>
    @setState count: @state.count+1

  onStopCurrent: =>
    @props.onStopCurrent(@props.activity)

  render: ->
    countdown.setLabels(
      '|||hr|d',
      'ms|s|m|||wks||yrs',
      ', ');
    endTime = if @props.activity.end then moment(@props.activity.end) else null
    duration = countdown(moment(@props.activity.start), endTime).toString()

    classes = ['btn', 'pull-left']
    disabled = @props.endTime?

    `<div className="container-fluid">
      <div className="row">
        <h1>Currently: {this.props.activity.description}</h1>
        <h4>{duration}</h4>
        <button className={classes.join(" ")}
            onClick={this.onStopCurrent}
            disabled={disabled}>
            Stop Tracking
          </button>
      </div>
    </div>`

@ActivityCurrent = ActivityCurrent
