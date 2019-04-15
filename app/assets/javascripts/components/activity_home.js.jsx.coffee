#= require ../models
#= require_tree ./ui/

class ActivityHome extends React.Component

  constructor: (props) ->
    @state = 
      collection: new ActivityCollection(props.initialCollection)
      goals: new GoalCollection(props.goals)

    @state.goals.on 'sync', =>
      @setState goals: @state.goals

    @state.collection.on 'sync', =>
      @setState collection: @state.collection

  componentDidMount: ->
    # prevent initial request for collection if already set
    if !@props.initialCollection?
      @updateActivities()

    if !@props.goals?
      @updateGoals()

  updateActivities: =>
    @state.collection.fetch()

  updateGoals: =>
    @state.goals.fetch()

  onStopCurrent: (e) =>
    ($.ajax url: e.stop, type: 'PUT').success =>
      @updateActivities()

  render: =>
    list = @state.collection.map (amodel) ->
      # return just the hash of attributes for now
      amodel.attributes

    current = null
    if @state.collection.getCurrent()?
      current = `<ActivityCurrent onStopCurrent={this.onStopCurrent} activity={this.state.collection.getCurrent().attributes} />`
    else
      current = `<div className="row"><h1>No current activity</h1></div>`

    updater = @updateActivities

    obj = tabs: [
      {name: "Current", component: current}
      {name: "New Activity", component: `<ActivityNew collection={this.state.collection} />`}
      {name: "List", component: `<ActivityList sort_descending={true} updater={updater} activities={list}/>`}
      {name: "History", component: `<ActivityHistory updater={updater} activities={this.props.history} />`}
      {name: "Goals", component: `<ActivityDailyGoals list={this.state.goals}></ActivityDailyGoals>`}
    ]

    `<div className='container-fluid'>
      <ActivityTabbed tabs={obj.tabs} />
    </div>`

@ActivityHome = ActivityHome
