
class GoalDuration extends React.Component

  render: () =>

    `<span className="badge">Time Spent: {moment.duration({seconds: this.props.duration}).asHours()} hours</span>`

@GoalDuration = GoalDuration