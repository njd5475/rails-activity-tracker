
class Goal extends React.Component
  remove: =>
    @props.model.destroy().success =>
      @props.list.fetch()
      @props.changed() if @props.changed?

  render: =>
    createdDate = moment(this.props.created_at).format('YYYY MMM DD');

    `<div className="panel panel-default">
      <div className="panel-heading">
        <span>Name:</span>{this.props.name}
      </div>
      
      <div className="panel-body">
        <label>Created:</label>
        <div>{createdDate}</div>
        <button className="btn btn-primary" onClick={this.remove}>Remove</button>
      </div>
    </div>`

@Goal = Goal