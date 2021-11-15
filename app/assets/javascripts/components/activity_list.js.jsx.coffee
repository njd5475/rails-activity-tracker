#= require underscore

Row = ReactBootstrap.Row

class ActivityList extends React.Component
  render: =>
    title = @props.title || "Todays"
    updater = @props.updater
    activities = @props.activities

    if @props.sort_descending
      activities = _.sortBy activities, (a) ->
        return moment(a.end || a.start).valueOf() * -1

    startTracking = @props.startTracking

    list = _.map activities, (activity) ->
      `<Activity startTracking={startTracking} table={true} key={activity.id} updater={updater} activity={activity} />`

    `<div className="container-fluid">
      <div className="row">
        <h3>{title} <span className="badge">{this.props.activities.length}</span></h3>
      </div>
      <div className="table-responsive row">
        <table className="table table-striped table-hover">
          <thead>
            <tr>
              <th>Begin - End</th>
              <th>Date (time elapsed)</th>
              <th>Activity name</th>
              <th>Actions</th>
              <th>Duration</th>
              <th>Goal</th>
            </tr>
          </thead>
          <tbody>
          {list}
          </tbody>
        </table>
      </div>
    </div>`

@ActivityList = ActivityList
