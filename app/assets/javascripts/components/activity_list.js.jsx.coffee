#= require underscore

Row = ReactBootstrap.Row

class ActivityList extends React.Component
  render: ->
    title = @props.title || "Todays"
    updater = @props.updater
    activities = @props.activities

    if @props.sort_descending
      activities = _.sortBy activities, (a) ->
        return moment(a.end || a.start).valueOf() * -1

    list = _.map activities, (activity) ->
      `<Activity key={activity.id} updater={updater} {...activity} />`

    `<Row>
      <div className="container">
        <div className="row">
          <h3>{title}</h3>
        </div>
        <div className="row">
          <div className="container">
            {list}
          </div>
        </div>
      </div>
    </Row>`

@ActivityList = ActivityList
