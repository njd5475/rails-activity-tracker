#= require ../models

class ActivityHistory extends React.Component
  constructor: (props) ->
    super props
    
  render: =>

    `<div className="container-fluid">
      <div className="row">
        <div className="col-md-12">
          <ActivityList startTracking={this.props.startTracking} title="History" updater={this.props.updater} activities={this.props.activities}/>
        </div>
      </div>
    </div>`

@ActivityHistory = ActivityHistory
