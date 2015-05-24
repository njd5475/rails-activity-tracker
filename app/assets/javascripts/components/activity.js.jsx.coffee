#= require countdownjs

@Activity = React.createClass
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
    endTime = if @props.end then moment(@props.end) else null
    duration = countdown(moment(@props.start), endTime).toString()

    `<div className="row-fluid">
      <div className="col-md-2">
        <ActivityTime time={this.props.start} />
        &nbsp;-&nbsp;
        <ActivityTime time={this.props.end} />
      </div>
      <div className="col-md-8">
        {this.props.description}
      </div>
      <div className="col-md-2">
        {duration}
      </div>
    </div>`