#= require moment
#= require countdownjs

@ActivityCurrent = React.createClass
  getInitialState: ->
    count: 0

  componentDidMount: ->
    @setState interval: setInterval @updateCount, 1000

  componentDidUnmount: ->
    clearInterval(@state.interval)

  updateCount: ->
    @setState count: @state.count+1

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
              <h4>{this.props.activity.description}</h4>
            </div>
            <div className="row">
              <h6>{duration}</h6>
            </div>
          </div>
        </div>
      </div>
    </div>`