#= require countdownjs

class ActivityTotal extends React.Component
  render: ->
    elapsed = moment.duration(@props.time).humanize()

    `<div>
      {this.props.title} - {elapsed}
    </div>`

@ActivityTotal = ActivityTotal
