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

  handleStop: ->
    ($.ajax url: @props.stop, type: 'PUT').success =>
      @props.updater()

  render: ->
    countdown.setLabels(
      '|||hr|d',
      'ms|sec|min|||wks||yrs',
      ', ');
    endTime = if @props.end then moment(@props.end) else null
    duration = countdown(moment(@props.start), endTime).toString()
    active = ""
    if !@props.end
      active = " (active)"

    resume = ''
    stop = ''
    if !@props.end
      handler = this.handleStop.bind(@)
      stop = `<ActivityStop stop={handler} />`
    else
      resume = `<ActivityResume />`

    `<div className="row">
      <div className="col-xs-2 col-md-2">
        <ActivityTime time={this.props.start} />
        &nbsp;-&nbsp;
        <ActivityTime time={this.props.end} />
      </div>
      <div className="col-xs-4 col-md-4">
        {this.props.description}{active}
        {stop}
      </div>
      <div className="col-xs-6 col-md-6">
        {duration}
      </div>
    </div>`
