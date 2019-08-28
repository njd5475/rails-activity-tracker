class ActivityNew extends React.Component
  state:
    userInput: ''

  handleChange: (e) =>
    @setState userInput: e.target.value

  startTracking: (e) =>
    e.preventDefault()
    model = new ActivityModel description: @state.userInput
    model.save().success(=>
      @props.collection.fetch()
      @props.changed() if @props.changed?
    ).fail(=>
      console.log(arguments)
    )
    return false #for form submission

  render: =>
    newText = 'New'
    trackingText = "Start Tracking"
    if @props.collection.getCurrent()?
      trackingText = "Switch"
      newText = 'Switch'

    `<div className="row">
      <div className="col-md-12">
        <h3>{newText} Activity</h3>
        <form className="form-inline">
          <div className="form-group">
            <input
              type="text"
              className="form-control"
              value={this.state.userInput}
              onChange={this.handleChange} />
            <button
              type="submit"
              className="btn btn-default pull-right"
              onClick={this.startTracking}>{trackingText}</button>
          </div>
        </form>
      </div>
    </div>`

@ActivityNew = ActivityNew
