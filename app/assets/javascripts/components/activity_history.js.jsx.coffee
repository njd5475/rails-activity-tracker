#= require ../models

class ActivityHistory extends React.Component
  constructor: (props) ->
    super props
    
  render: =>
    `<div className="container-fluid">
      <div className="row">
        <div className="col-md-12">
          <ActivityList title="History" updater={this.props.updater} activities={this.props.activities}/>
        </div>
      </div>
      <ActivitySummary activities={this.props.activities} />
    </div>`

@ActivityHistory = ActivityHistory
