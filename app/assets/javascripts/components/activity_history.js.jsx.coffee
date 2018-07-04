#= require ../models

class ActivityHistory extends React.Component
  render: ->
    `<div>
      <ActivityList title="History" updater={this.props.updater} activities={this.props.activities}/>
      <ActivitySummary activities={this.props.activities} />
    </div>`

@ActivityHistory = ActivityHistory
