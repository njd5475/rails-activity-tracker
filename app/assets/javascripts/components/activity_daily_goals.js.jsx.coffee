
class ActivityDailyGoals extends React.Component

    constructor: (props) ->
        @state =
            userInput: ''
            working: false
            goals: props.list

    handleChange: (e) =>
        @setState userInput: e.target.value

    changed: =>
        @setState goals: @props.collection.getAll()

    newGoal: (e) =>
        e.preventDefault()

        @setState working: true, () => 
            goal = new GoalModel name: @state.userInput
            goal.save().success =>
                @props.collection.fetch().success =>
                    @setState goals: @props.collection.getAll(), () =>
                        @setState working: false

    render: =>
        disabled = @state.working

        theList = @props.collection
        
        changedListener = @changed
        goals = @state.goals.map (goal, i) =>
            model = theList.find (g) -> g.id == goal.id
            goal = goal.attributes if goal.attributes?
            `<Goal key={i} {...goal} list={theList} model={model} changed={changedListener} />`

        `<div className="container-fluid">
            <div className="row">
                <div className="col-md-12">
                    <h2>Activity Daily Goals</h2>
                    <div className="row">
                        <div className="col-md-12">
                            <form className="form-inline" action="/goals" method="POST">
                                <div className="form-group">
                                    <div className="input-group">
                                        <input 
                                            className="form-control" 
                                            type="text" 
                                            id="name" 
                                            placeholder="Goal Name"
                                            value={this.state.userInput}
                                            onChange={this.handleChange} />
                                    </div>
                                </div>
                                <button 
                                    className="btn btn-primary" 
                                    type="submit"
                                    disabled={disabled}
                                    onClick={this.newGoal}>Add</button>  
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div className="row">
                <div className="col-md-12">
                    <h3>Goals List</h3>
                </div>
            </div>
            <div className="row">
                <div className="col-md-12">
                    {goals}
                </div>
            </div>
        </div>`

@ActivityDailyGoals = ActivityDailyGoals