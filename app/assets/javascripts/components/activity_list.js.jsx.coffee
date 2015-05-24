#= require underscore

@ActivityList = React.createClass
  render: ->
    list = _.map @props.activities, (activity) ->
      `<Activity description={activity.description} start={activity.start} end={activity.end} />`
    `<div className="row-fluid">
      {list}
    </div>`