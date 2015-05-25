#= require underscore

@ActivityList = React.createClass
  render: ->
    list = _.map @props.activities, (activity) ->
      `<Activity description={activity.description} start={activity.start} end={activity.end} />`
    `<div className="row">
      <div className="container">
        <div className="row">
          <h3>Todays</h3>
        </div>
        <div className="row">
          <div className="container">
            {list}
          </div>
        </div>
      </div>
    </div>`