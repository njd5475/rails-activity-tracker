@ActivityEdit = React.createClass
  getInitialState: ->
    return userInput: ''

  handleChange: (e) ->
    @setState userInput: e.target.value

  startTracking: ->
    model = new ActivityModel description: @state.userInput
    model.save()

  render: ->
    `<div>
      <input
        ref="description"
        type="text"
        value={this.state.userInput}
        onChange={this.handleChange} />
      <button onClick={this.startTracking}>Start Tracking</button>
    </div>`