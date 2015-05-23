#= require underscore

@ActivityList = React.createClass
  render: ->
    list = _.map @props.activities, (activity) ->
      `<Activity description={activity.description} />`
    `<div>
      {list}
    </div>`