
class GoalDuration extends React.Component

  render: () =>

    `<span className="badge">Time Spent: {moment.duration({seconds: this.props.duration}).humanize()}</span>`

@GoalDuration = GoalDuration