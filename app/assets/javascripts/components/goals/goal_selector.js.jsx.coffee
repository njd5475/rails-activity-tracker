  
class GoalSelector extends React.Component
  constructor: (props) ->
    super props
    init = 'noselect'
    @state =
      editing: !!props.id
      name: props.name
      display: init
      options: @optionList(props)
      # updating: false
      # loading: true
  
  componentWillReceiveProps: (props) =>
    @props = props
    display = @state.display
    display = 'noselect' if !@state.editing && display == 'select' && props.name

    # @setState loading: false, display: display, options: @optionList(props), name: props.name

  editGoal: =>
    @setState editing: true, display: 'select'

  hideSelect: =>
    @setState editing: false, display: 'noselect'

  changeSelection: (e) =>
    goalId = e.target.selectedOptions.item(0).value
    goal = undefined
    if goalId != ' '
      goal = _.find @props.goals, (goal) -> goal.id.toString() == goalId

    # @setState updating:true, () => 
    #   @props.listener(goal).error(() => @setState updating: false).done(() => @setState updating: false) if @props.listener and goal
    #   @setState display: 'noselect'

  render: ->
    goal = ""

    if @state.display == 'select'
      goal = `<select defaultValue="DEFAULT" value={this.id} onChange={this.changeSelection}>{this.state.options}</select>`
    else
      goal = `<div onClick={this.editGoal}>{this.state.name || 'N/A'}</div>`

    # monitor = []
    # if @state.updating || @state.loading
    #   monitor.push `<Spinner />`
    #   goal = []

    # `<div>{monitor}{goal}</div>`

  optionList: (props) =>
    return [] if !props.goals

    options = props.goals.map (goal) ->
      `<option key={goal.id} value={goal.id}>{goal.name}</option>`

    options.unshift `<option key={'DEFAULT'} value="DEFAULT"></option>`

    return options

@GoalSelector = GoalSelector