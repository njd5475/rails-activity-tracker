#= require ../models

@ActivityHome = React.createClass
  getInitialState: ->
    col = new ActivityCollection(@props.initialCollection)
    col.on 'sync', =>
      @setState collection: @state.collection

    collection: col

  componentDidMount: ->
    @updateActivities()

  updateActivities: ->
    @state.collection.fetch()

  render: ->
    list = @state.collection.map (amodel) ->
      # return just the hash of attributes for now
      amodel.attributes

    current = null
    if @state.collection.getCurrent()?
      current = `<ActivityCurrent activity={this.state.collection.getCurrent().attributes} />`

    `<div className='container'>
      {current}
      <ActivityEdit collection={this.state.collection} />
      <ActivityList activities={list}/>
    </div>`
