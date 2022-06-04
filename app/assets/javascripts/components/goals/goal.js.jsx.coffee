
class Goal extends React.Component

  constructor: (props) ->

    debugger if not props.name?

  remove: =>
    @props.model.destroy().success =>
      @props.list.fetch()
      @props.changed() if @props.changed?

  handleDateChange: (date) =>
    @props.model.set target_date: date
    @props.model.save {target_date: date}, success: =>
      @props.changed()

  render: =>
    createdDate = moment(this.props.created_at).format('YYYY MMM DD');
    targetDate = moment(this.props.target_date).format('YYYY MMM DD');

    labelStyle = float: 'left', marginRight: 12
    titleStyle = paddingTop: 8, display: 'inline-block'

    console.log('Goal name=' + this.props.name);

    `<div className="panel panel-default">
      <div className="panel-heading">
        <h4 className="panel-title clearfix">
          <span style={titleStyle}>{this.props.name}</span>
          <div className="btn-group pull-right">
            <div className="btn">
            <GoalDuration duration={this.props.duration} />{"\n"}
            </div>
            <a className="btn btn-default btn-sm" onClick={this.remove} aria-label="Delete">
              <span className="glyphicon glyphicon-remove-sign" aria-hidden="true" />
            </a>
          </div>
        </h4>
      </div>

      <div className="panel-body">
          <div className="row">
            <div className="col-sm-6">
              <label style={labelStyle}>Created:</label>
              <div>{createdDate}</div>
              
            </div>
            <div className="col-sm-6">
              <label style={labelStyle}>Target Date:</label>
              <div>{targetDate}</div>
              <DatePicker handler={this.handleDateChange.bind(this)}/>
            </div>
          </div>
          <div className="row">
            <div className="col-sm-12">
              <label style={labelStyle}>Activities</label>
              <div>{this.props.activity_count}</div>
            </div>
          </div>
      </div>
    </div>`

@Goal = Goal