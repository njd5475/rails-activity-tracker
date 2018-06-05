@MainNav = React.createClass
  logoutComponent: ->
    if !@props.logout_url then return ''

    return `<li>
      <a href={this.props.logout_url} data-method="delete">Logout</a>
    </li>`

  usernameDisplay: ->
    if !@props.username then return

    return `<li>
      <p className="navbar-text">{this.props.username}</p>
    </li>`

  render: ->

    `<nav className="navbar navbar-default">
      <div className="collapse navbar-collapse">
        <ul className="nav navbar-nav navbar-right">
          {this.usernameDisplay()}
          {this.logoutComponent()}
        </ul>
      </div>
    </nav>`
