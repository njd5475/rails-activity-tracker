#= require countdownjs

@ActivityTotal = React.createClass
  render: ->
    elapsed = moment.duration(@props.time).humanize()

    `<div>
      {this.props.title} - {elapsed}
    </div>`
