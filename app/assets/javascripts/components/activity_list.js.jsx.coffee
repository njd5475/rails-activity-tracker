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

    list = _.map activities, (activity) ->
      `<Activity table={true} key={activity.id} updater={updater} {...activity} />`

    `<div className="container">
      <div className="row">
        <h3>{title}</h3>
      </div>
      <div className="table-responsive">
        <table className="table table-striped table-hover">
          <thead>
            <tr>
              <th>Begin - End</th>
              <th>Date (time elapsed)</th>
              <th>Activity name</th>
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
