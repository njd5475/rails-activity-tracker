#= require ../models
#= require_tree ./ui/

class ActivityHome extends React.Component

  constructor: (props) ->
    @state = 
      activityObj: new ActivityCollection(props.initialCollection)
      activities: props.initialCollection
      goalsObj: new GoalCollection(props.goals)
      goals: props.goals

    @state.goalsObj.on 'sync change reset add remove', =>
      theGoals = @state.goalsObj.getAll()
      console.log("Goals updated and got " + theGoals.length)
      @setState goals: theGoals,
        @tabs.updateMe

    @state.activityObj.on 'sync change reset add remove', =>
      @setState activities: @state.activityObj.getAll(),
        @tabs.updateMe

  componentDidMount: ->
    # prevent initial request for collection if already set
    if !@props.initialCollection?
      @updateActivities()

    if !@props.goals?
      @updateGoals()

  updateActivities: =>
    @state.activityObjs.fetch()

  updateGoals: =>
    @state.goalsObj.fetch()

  onStopCurrent: (e) =>
    ($.ajax url: e.stop, type: 'PUT').success =>
      @updateActivities()

  render: =>
    list = @state.activityObj.getAll()

    current = null
    if @state.activityObj.getCurrent()?
      current = `<ActivityCurrent key={0} onStopCurrent={this.onStopCurrent} activity={this.state.activityObj.getCurrent().attributes} />`
    else
      current = `<div key={0} className="row"><h1>No current activity</h1></div>`

    updater = @updateActivities

    tabs = []
    tabs.push name: "Current",      component: current
    tabs.push name: "New Activity", component: `<ActivityNew        key={1} collection={this.state.activityObj} />`
    tabs.push name: "List",         component: `<ActivityList       key={2} sort_descending={true} updater={updater} activities={list}/>`
    tabs.push name: "History",      component: `<ActivityHistory    key={3} updater={updater} activities={this.props.history} />`
    tabs.push name: "Goals",        component: `<ActivityDailyGoals key={4} list={this.state.goals} collection={this.state.goalsObj} />`

    `<div className='container-fluid'>
      <ActivityTabbed ref={instance => this.tabs = instance} tabs={tabs} updates={this.state.updateTabs}/>
    </div>`

@ActivityHome = ActivityHome
