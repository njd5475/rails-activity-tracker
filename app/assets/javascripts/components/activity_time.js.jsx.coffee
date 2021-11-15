
class ActivityTime extends React.Component
  constructor: (props) ->
    super props
    @state =
      time: props.time
      display: "noselect"
      options: @optionList(props)
      changing: false

  editTime: =>
    if @state.display == "select"
      @setState(display: 'noselect')
    else
      @setState(display: 'select')

  hideSelect: (event) =>
    @setState(display: 'noselect')

  changeActivity: (event) =>
    val = event.target.value
    
    m = moment(val)

    if @props.type == 'start'
      @setState changing: true, () =>
        ($.ajax 
          url: @props.activityUpdateUrl,
          contentType: 'application/json'
          type: 'PUT', 
          data: JSON.stringify(start: m.format())
        ).success (a) =>
          @setState changing: false, time: a.start, display: 'noselect', options: @optionList(@state), () =>
            @props.refreshActivity()
        .error (a) =>
          @setState changing: false
    
    if @props.type == 'end'
      @setState changing: true, () =>
        ($.ajax 
          url: @props.activityUpdateUrl,
          contentType: 'application/json'
          type: 'PUT', 
          data: JSON.stringify(end: m.format())
        ).success (a) =>
          @setState changing: false, time: a.end, display: 'noselect', options: @optionList(@state), () =>
            @props.refreshActivity()
        .error (a) =>
          @setState changing: false


  render: ->
    time = ""
    if @state.time
      time = moment(@state.time).format("hh:mm")

    if @state.display == 'select'
      time = `<select onMouseOut={this.hideSelect} onChange={this.changeActivity}>{this.state.options}</select>`
    else
      time = `<span onClick={this.editTime}>{time}</span>`

    if @state.changing
      time = `<Spinner />`

    `<span>{time}</span>`

  optionList: (props) =>
    if !props.time?
      return []

    time = props.time
    list = []
    nums = [1..20]
    for x in nums
      if x < nums.length/2
        list[x] = `<option key={x} value={moment(time).subtract(nums.length/2-x, 'hour')}>-{nums.length/2-x}h {moment(time).subtract(nums.length/2-x, 'hour').format("hh:mm  MM/DD")}</option>`
      else
        list[x] = `<option key={x} value={moment(time).add(x-nums.length/2, 'hour')}>+{x-nums.length/2}h {moment(time).add(x-nums.length/2, 'hour').format('hh:mm MM/DD')}</option>`

    return list

@ActivityTime = ActivityTime
