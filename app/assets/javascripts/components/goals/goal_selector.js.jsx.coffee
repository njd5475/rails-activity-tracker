
class GoalSelector extends React.Component
  constructor: (props) ->
    super props
    init = 'noselect'
    @state =
      editing: !!props.id
      name: props.name
      display: init
      options: @optionList(props)
  
  componentWillReceiveProps: (props) =>
    @props = props
    console.log "Component Will Receive Props"
    display = @state.display
    display = 'noselect' if !@state.editing && display == 'select' && props.name

    @setState display: display, options: @optionList(props), name: props.name

  editGoal: =>
    @setState editing: true, display: 'select'

  hideSelect: =>
    console.log "Hide the select"
    @setState editing: false, display: 'noselect'

  changeSelection: (e) =>
    console.log "Change selection"
    goalId = e.target.selectedOptions.item(0).value
    goal = undefined
    if goalId != ' '
      goal = _.find @props.goals, (goal) -> goal.id.toString() == goalId

    @props.listener(goal) if @props.listener and goal
    @setState display: 'noselect'

  render: ->
    goal = ""

    if @state.display == 'select'
      goal = `<select defaultValue="DEFAULT" value={this.id} onChange={this.changeSelection}>{this.state.options}</select>`
    else
      goal = `<div onClick={this.editGoal}>{this.state.name || 'N/A'}</div>`

    `<div>{goal}</div>`

  optionList: (props) =>
    return [] if !props.goals

    options = props.goals.map (goal) ->
      `<option key={goal.id} value={goal.id}>{goal.name}</option>`

    options.unshift `<option key={'DEFAULT'} value="DEFAULT"></option>`

    return options

@GoalSelector = GoalSelector