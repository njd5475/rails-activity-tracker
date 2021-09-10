#= require countdownjs
#= require moment

class Activity extends React.Component

  constructor: (props) ->
    super props
    @state = 
      count: 0
      goals: []

  render: =>
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
      handler = this.handleStop
      stop = `<ActivityStop stop={handler} />`
    else
      resume = `<ActivityResume resume={this.handleResume} />`

    isTable = @props.table or false

    startTime = moment(this.props.start).format('L')
    ago = moment(this.props.start).fromNow()

    if isTable
      return `<tr>
          <td>
            <ActivityTime time={this.props.start} type="start" activityUpdateUrl={this.props.activity_update_url} />
            &nbsp;-&nbsp;
            <ActivityTime time={this.props.end} type="end" activityUpdateUrl={this.props.activity_update_url} />
          </td>
          <td>
            {startTime} <em>({ago})</em>
          </td>
          <td>
            {this.props.description}{active}
            {stop}{resume}
          </td>
          <td>
            {duration}
          </td>
          <td>
            <GoalSelector goals={this.state.goals} listener={this.goalChanged} {...this.state.goal}/>
          </td>
        </tr>`
    else
      return `<div className="row">
        <div className="col-xs-2 col-md-2">
          <ActivityTime time={this.props.start} />
          &nbsp;-&nbsp;
          <ActivityTime time={this.props.end} activityUpdateUrl={this.props.updateUrl} />
        </div>
        <div className="col-xs-2 col-md-2">
          {startTime} <em>({ago})</em>
        </div>
        <div className="col-xs-4 col-md-4">
          {this.props.description}{active}
          {stop}
        </div>
        <div className="col-xs-2 col-md-2">
          {duration}
        </div>
        <div className="col-xs-2 col-md-2">
          <GoalSelector goals={this.state.goals} listener={this.goalChanged} {...this.state.goal}/>
        </div>
      </div>`

  componentDidMount: =>
    @setState interval: setInterval @updateCount, 1000

    @retrieveGoals()
    @retrieveGoal()

  componentWillUnmount: =>
    clearInterval(@state.interval)

  updateCount: =>
    @setState count: @state.count+1

  handleResume: =>
    @props.startTracking @props.description

  handleStop: =>
    ($.ajax url: @props.stop, type: 'PUT').success =>
      @props.updater()

  goalChanged: (goal) =>
    ($.ajax url: "#{goal.activities_url}/#{this.props.id}", type: 'PUT').success =>
      @setState goal: goal

  retrieveGoals: =>
    if @props.goals_url
      ($.ajax url: @props.goals_url, type: 'GET',  dataType: 'json').success (results) =>
        @setState goals: results

  retrieveGoal: =>
    if @props.goal_url
      ($.ajax url: @props.goal_url, type: 'GET', dataType: 'json').success (goal) =>
        @setState goal: goal

@Activity = Activity
