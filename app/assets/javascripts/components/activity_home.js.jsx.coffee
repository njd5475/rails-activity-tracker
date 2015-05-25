#= require ../models

@ActivityHome = React.createClass
  getInitialState: ->
    col = new ActivityCollection
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

    `<div className='container-fluid'>
      <ActivityEdit collection={this.state.collection} />
      <ActivityList activities={list}/>
    </div>`
