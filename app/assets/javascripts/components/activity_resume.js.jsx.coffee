#= require ../models

class ActivityResume extends React.Component
  render: =>
    resume = @props.resume

    `<button onClick={resume}><i className="glyphicon glyphicon-play"></i></button>`

@ActivityResume = ActivityResume
