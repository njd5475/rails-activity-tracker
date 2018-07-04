#= require ../models

class ActivityHome extends React.Component
  state:
    collection: new ActivityCollection([])

  constructor: (props) ->
    @col = new ActivityCollection(props.initialCollection)
    @col.on 'sync', =>
      @setState collection: @state.collection

  componentDidMount: ->
    # prevent initial request for collection if already set
    if !@props.initialCollection?
      @updateActivities()

  updateActivities: ->
    @state.collection.fetch()

  onStopCurrent: (e) ->
    ($.ajax url: e.stop, type: 'PUT').success =>
      @updateActivities()

  render: ->
    list = @state.collection.map (amodel) ->
      # return just the hash of attributes for now
      amodel.attributes

    current = null
    if @state.collection.getCurrent()?
      current = `<ActivityCurrent onStopCurrent={this.onStopCurrent} activity={this.state.collection.getCurrent().attributes} />`
    else
      current = `<div className="row"><h1>No current activity</h1></div>`

    updater = @updateActivities

    `<div className='container'>
      {current}
      <ActivityNew collection={this.state.collection} />
      <ActivityList sort_descending={true} updater={updater} activities={list}/>
      <ActivityHistory updater={updater} activities={this.props.history} />
    </div>`

@ActivityHome = ActivityHome
