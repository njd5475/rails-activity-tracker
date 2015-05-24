@ActivityEdit = React.createClass
  getInitialState: ->
    return userInput: ''

  handleChange: (e) ->
    @setState userInput: e.target.value

  startTracking: ->
    model = new ActivityModel description: @state.userInput
    model.save()
    return false #for form submission

  render: ->
    `<div className="row-fluid">
      <form className="form-inline">
        <div className="form-group">
          <input
            ref="description"
            type="text"
            className="form-control"
            value={this.state.userInput}
            onChange={this.handleChange} />
          <button
            type="submit"
            className="btn btn-default"
            onClick={this.startTracking}>Start Tracking</button>
        </div>
      </form>
    </div>`