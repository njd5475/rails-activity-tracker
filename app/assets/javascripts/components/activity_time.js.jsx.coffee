#= require moment

class ActivityTime extends React.Component
  constructor: (props) ->
    super props
    @state =
      display: "noselect"
      options: @optionList(props)

  editTime: =>
    if @state.display == "select"
      @setState(display: 'noselect')
    else
      @setState(display: 'select')

  hideSelect: =>
    @setState(display: 'noselect')

  render: ->
    time = ""
    if @props.time
      time = moment(@props.time).format("hh:mm")

    if @state.display == 'select'
      time = `<select onMouseOut={this.hideSelect}>{this.state.options}</select>`
    else
      time = `<span onClick={this.editTime}>{time}</span>`

    `<span>{time}</span>`

  optionList: (props) =>
    if !props.time?
      return []

    time = props.time
    list = []
    nums = [1..20]
    for x in nums
      if x < nums.length/2
        list[x] = `<option key={x}>-{nums.length/2-x}h {moment(time).subtract(nums.length/2-x, 'hour').format("hh:mm  MM/DD")}</option>`
      else
        list[x] = `<option key={x}>+{x-nums.length/2}h {moment(time).add(x-nums.length/2, 'hour').format('hh:mm MM/DD')}</option>`

    return list

@ActivityTime = ActivityTime
