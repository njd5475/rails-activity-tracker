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

  startTracking: (desc) =>
    @activityNew.setTracking desc, () =>
      @updateActivities()

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
    startTracking = @startTracking

    tabs = []
    tabs.push name: "Todays List",  component: `<ActivityList       key={tabs.length} startTracking={startTracking} sort_descending={true} updater={updater} activities={list} />`
    tabs.push name: "Summary",      component: `<ActivitySummary    key={tabs.length} startTracking={startTracking} activities={this.props.history} />`
    tabs.push name: "History",      component: `<ActivityHistory    key={tabs.length} startTracking={startTracking} updater={updater} activities={this.props.history} />`
    tabs.push name: "Goals",        component: `<ActivityDailyGoals key={tabs.length} startTracking={startTracking} list={this.state.goals} collection={this.state.goalsObj} />`

    `<div className='container-fluid'>
      <div className='row'>
        <div className='col-md-6'>
          {current}
        </div>
        <div className='col-md-3'>
          <div className="well">
            <ActivityNew ref={ref => this.activityNew = ref} collection={this.state.activityObj} />
          </div>
        </div>
      </div>
      <div className="row">
        <div className='col-md-12'>
          <ActivityTabbed ref={instance => this.tabs = instance} tabs={tabs} />
        </div>
      </div>
    </div>`

@ActivityHome = ActivityHome
