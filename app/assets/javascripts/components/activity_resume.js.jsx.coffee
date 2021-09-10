#= require ../models

class ActivityResume extends React.Component
  render: =>
    resume = @props.resume

    `<button onClick={resume}>Resume</button>`

@ActivityResume = ActivityResume
