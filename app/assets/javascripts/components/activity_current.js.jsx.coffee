#= require moment
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
      'ms|sec|min|||wks||yrs',
      ', ');
    endTime = if @props.activity.end then moment(@props.activity.end) else null
    duration = countdown(moment(@props.activity.start), endTime).toString()

    `<div className="row">
      <div className="container">
        <div className="row">
          <h1>Current Activity</h1>
        </div>
        <div className="row">
          <div className="container">
            <div className="row">
              <div className="pull-right">
                <button className="btn"
                  onClick={this.onStopCurrent}>
                  Stop Tracking
                </button>
              </div>
              <h4>{this.props.activity.description}</h4>
            </div>
            <div className="row">
              <h6>{duration}</h6>
            </div>
          </div>
        </div>
      </div>
    </div>`

@ActivityCurrent = ActivityCurrent
