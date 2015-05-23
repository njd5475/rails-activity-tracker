@ActivityHome = React.createClass
  getInitialState: ->
    collection: null

  componentDidMount: ->
    if !@state.collection
      col = new ActivityCollection
      col.fetch()
      @setState collection: col


  render: ->
    `<div>
      <ActivityEdit />
      <ActivityList />
    </div>`
