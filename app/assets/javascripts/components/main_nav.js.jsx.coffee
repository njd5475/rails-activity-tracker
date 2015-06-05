@MainNav = React.createClass
  render: ->
    `<nav className="navbar navbar-default">
      <div className="collapse navbar-collapse">
        <ul className="nav navbar-nav navbar-right">
          <li>
            <p className="navbar-text">{this.props.username}</p>
          </li>
          <li>
            <a href={this.props.logout_url} data-method="delete">Logout</a>
          </li>
        </ul>
      </div>
    </nav>`