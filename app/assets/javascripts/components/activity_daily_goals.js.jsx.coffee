
class ActivityDailyGoals extends React.Component
    state:
        userInput: ''
        working: false

    handleChange: (e) =>
        @setState userInput: e.target.value

    newGoal: (e) =>
        e.preventDefault()

        @setState working: true
        goal = new GoalModel name: @state.userInput
        goal.save().done =>
            @setState working: false

    render: =>
        disabled = @state.working

        goals = @props.list.map (goal, i) =>
            `<Goal key={i} {...goal.attributes} />`

        `<div className="container-fluid">
            <div className="row">
                <div className="col-md-9">
                    Activity Daily Goals
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
            <div className="row">
                <div className="col-md-9">
                    {goals}
                </div>
            </div>
        </div>`

@ActivityDailyGoals = ActivityDailyGoals