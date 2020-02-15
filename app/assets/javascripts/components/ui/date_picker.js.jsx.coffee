
class DatePicker extends React.Component

  handleChange: (date) =>
    @props.handler(date.target.value) if @props.handler?

  render: ->
    `<div><input type="date" onChange={this.handleChange}/></div>`

@DatePicker = DatePicker