
class GoalSelector extends React.Component
  constructor: (props) ->
    super props
    init = 'noselect'
    init = 'select' if !props.name
    @state =
      display: init
      options: @optionList(props)
  
  componentWillReceiveProps: (props) =>
    display = 'select'
    if props.id
      display = 'noselect' 
    @setState display: display, options: @optionList(props)

  editGoal: =>
    if @state.display == 'select'
      @setState display: 'noselect'
    else
      @setState display: 'select'

  hideSelect: =>
    @setState display: 'noselect'

  changeSelection: (e) =>
    goalId = e.target.selectedOptions.item(0).value
    goal = undefined
    if goalId != ' '
      goal = _.find @props.goals, (goal) -> goal.id.toString() == goalId

    @props.listener(goal) if @props.listener and goal
    @setState display: 'noselect'

  render: ->
    goal = ""

    if @state.display == 'select'
      goal = `<select defaultValue="DEFAULT" value={this.id} onChange={this.changeSelection} onMouseOut={this.hideSelect}>{this.state.options}</select>`
    else
      goal = `<div onClick={this.editGoal}>{this.props.name || 'N/A'}</div>`

    `<div>{goal}</div>`

  optionList: (props) =>
    return [] if !props.goals

    options = props.goals.map (goal) ->
      `<option key={goal.id} value={goal.id}>{goal.name}</option>`

    options.unshift `<option key={'DEFAULT'} value="DEFAULT"></option>`

    return options

@GoalSelector = GoalSelector