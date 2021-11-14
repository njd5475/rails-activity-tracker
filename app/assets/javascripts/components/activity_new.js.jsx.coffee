class ActivityNew extends React.Component
  state:
    userInput: ''

  handleChange: (e) =>
    @setState userInput: e.target.value

  setTracking: (desc, callback) =>
    @setState userInput: desc, () =>
      @startNew @state.userInput
      callback() if callback

  startTracking: (e) =>
    e.preventDefault()
    return @sendNewActivity @state.userInput

  sendNewActivity: (desc, callback) =>
    model = new ActivityModel description: desc
    return model.save().success(=>
      @props.collection.fetch()
      @props.changed() if @props.changed?
      callback() if callback
    ).fail( =>
      console.error(arguments)
    )

  startNew: (desc, callback) =>
    @sendNewActivity desc, callback
    return false #for form submission

  render: =>
    newText = 'New'
    trackingText = "Start"
    if @props.collection.getCurrent()?
      trackingText = "Switch"
      newText = 'Switch'

    `<div className="row">
      <div className="col-md-12">
        <div className="container-fluid">
          <div className="row">
            <h3>{newText} Activity</h3>
          </div>
          <div className="row">
          <div className="input-group">
            <span className="input-group-addon" onClick={this.startTracking}><i className="glyphicon glyphicon-play"></i></span>
            <input id="description" type="text" className="form-control" name="description" placeholder="Description" value={this.state.userInput} onChange={this.handleChange} />
          </div>
          </div>
        </div>
      </div>
    </div>`

@ActivityNew = ActivityNew
