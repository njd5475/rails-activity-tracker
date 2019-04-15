
class Goal extends React.Component
  render: =>
    createdDate = moment(this.props.created_at).format('YYYY MMM DD');

    `<div className="panel panel-default">
      <div className="panel-heading">
        <span>Name:</span>{this.props.name}
      </div>
      
      <div className="panel-body">
        <label>Created:</label>
        <div>{createdDate}</div>
      </div>
    </div>`

@Goal = Goal