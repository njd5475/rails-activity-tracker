#= require ../models

@ActivityHistory = React.createClass
  render: ->
    `<div>
      <ActivityList title="History" updater={this.props.updater} activities={this.props.activities}/>
    </div>`
