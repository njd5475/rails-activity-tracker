#= require ../models
#= require_tree ./ui/

class ActivityHome extends React.Component

  constructor: (props) ->
    @state = 
      activityObj: new ActivityCollection(props.initialCollection)
      activities: props.initialCollection
      goalsObj: new GoalCollection(props.goals)
      goals: props.goals

    @state.current = @state.activityObj.getCurrent()

    @state.goalsObj.on 'sync change reset add remove', =>
      theGoals = @state.goalsObj.getAll()
      @setState goals: theGoals, @updateTabs

    @state.activityObj.on 'sync change reset add remove', =>
      console.log(@state.activityObj.getCurrent())
      @setState 
        activities: @state.activityObj.getAll()
        activityObj: @state.activityObj
        current: @state.activityObj.getCurrent()
        , @updateTabs

  componentDidMount: ->
    # prevent initial request for collection if already set
    if !@props.initialCollection?
      @updateActivities()

    if !@props.goals?
      @updateGoals()

  updateTabs: =>
    console.log("Updating tabs called")
    @tabs.updateMe()

  updateActivities: =>
    @state.activityObj.fetch()

  updateGoals: =>
    @state.goalsObj.fetch()

  onStopCurrent: (e) =>
    ($.ajax url: e.stop, type: 'PUT').success =>
      @updateActivities()

  render: =>
    list = @state.activities

    current = null
    if @state.current?
      console.log("We have a current activity in state")
      current = `<ActivityCurrent key={0} onStopCurrent={this.onStopCurrent} activity={this.state.current.attributes} />`
    else
      console.log("There is no current activity")
      current = `<div key={0} className="row"><h1>No current activity</h1></div>`

    updater = @updateActivities

    tabs = []
    tabs.push name: "Current",      component: current
    tabs.push name: "Summary",      component: `<ActivitySummary    key={1} activities={this.props.history} />`
    tabs.push name: "New Activity", component: `<ActivityNew        key={2} collection={this.state.activityObj} />`
    tabs.push name: "List",         component: `<ActivityList       key={3} sort_descending={true} updater={updater} activities={list} />`
    tabs.push name: "History",      component: `<ActivityHistory    key={4} updater={updater} activities={this.props.history} />`
    tabs.push name: "Goals",        component: `<ActivityDailyGoals key={5} list={this.state.goals} collection={this.state.goalsObj} />`

    `<div className='container-fluid'>
      <ActivityTabbed ref={instance => this.tabs = instance} tabs={tabs} />
    </div>`

@ActivityHome = ActivityHome
