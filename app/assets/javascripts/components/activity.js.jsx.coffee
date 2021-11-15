#= require countdownjs

class Activity extends React.Component

  constructor: (props) ->
    super props
    @state = 
      activity: new ActivityModel(props.activity)
      count: 0
      goals: []
      changing: false

  refreshActivity: =>
    @state.activity.fetch().done =>
      @setState activity: @state.activity

  render: =>
    countdown.setLabels(
      '|||hr|d',
      'ms|sec|min|||wks||yrs',
      ', ');
    { end, start, description, activity_update_url } = @state.activity.attributes
    endTime = if end then moment(end) else null
    duration = countdown(moment(start), endTime).toString()
    active = ""
    if !end
      active = " (active)"

    resume = ''
    stop = ''
    if !end
      handler = this.handleStop
      stop = `<ActivityStop stop={handler} />`
    else
      resume = `<ActivityResume resume={this.handleResume} />`

    if @state.changing
      stop = ''
      resume = `<Spinner />`

    isTable = @props.table or false

    startTime = moment(start).format('L')
    ago = moment(start).fromNow()

    refreshActivity = @refreshActivity

    if isTable
      return `<tr>
          <td>
            <ActivityTime time={start} type="start" activityUpdateUrl={activity_update_url} refreshActivity={refreshActivity}/>
            &nbsp;-&nbsp;
            <ActivityTime time={end} type="end" activityUpdateUrl={activity_update_url} refreshActivity={refreshActivity}/>
          </td>
          <td>
            {startTime} <em>({ago})</em>
          </td>
          <td>
            {description}{active}
          </td>
          <td>
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
          <ActivityTime time={start} />
          &nbsp;-&nbsp;
          <ActivityTime time={end} activityUpdateUrl={this.props.updateUrl} />
        </div>
        <div className="col-xs-2 col-md-2">
          {startTime} <em>({ago})</em>
        </div>
        <div className="col-xs-2 col-md-2">
          {description}{active}
        </div>
        <div className="col-xs-2 col-md-2">
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
    @setState changing: true, () =>
      @props.startTracking(@props.description)
        .always =>
          @setState changing: false

  handleStop: =>
    @setState changing: true, () =>
      ($.ajax url: @props.stop, type: 'PUT')
        .success =>
          @props.updater()
          @setState changing: false
        .error =>
          @setState changing: false

  goalChanged: (goal) =>
    ($.ajax url: "#{goal.activities_url}/#{this.state.activity.attributes.id}", type: 'PUT').success =>
      @setState goal: goal

  retrieveGoals: =>
    goalUrl = @state.activity.attributes.goals_url
    if goalUrl
      ($.ajax url: goalUrl, type: 'GET',  dataType: 'json').success (results) =>
        @setState goals: results

  retrieveGoal: =>
    goalUrl = @state.activity.attributes.goal_url
    if goalUrl
      ($.ajax url: goalUrl, type: 'GET', dataType: 'json').success (goal) =>
        @setState goal: goal

@Activity = Activity
