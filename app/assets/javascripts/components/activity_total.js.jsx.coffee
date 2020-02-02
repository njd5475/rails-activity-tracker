#= require countdownjs

class ActivityTotal extends React.Component
  render: ->
    elapsed = moment.duration(@props.time).humanize()

    `<div>
       {elapsed} - {this.props.title}
    </div>`

@ActivityTotal = ActivityTotal
