
class ChartByDay extends ChartAggregator
  constructor: (dataset, day, denomination= 'minute') ->
    super(dataset)
    @day = day
    @year = moment().year()
    @daysInYear = Math.ceil(moment.duration(moment().endOf('year').diff(moment().startOf('year'))).asDays())
    @denomination = denomination

  datasetLabel: =>
    "#{@startDate().format('dddd MMMM D, YYYY')}"
  
  next: ->
    @day += 1
    @day = Math.min(@daysInYear, @day)

  previous: ->
    @day -= 1
    @day = Math.max(0, @day)

  startDate: (label = moment().year(@year).dayOfYear(@day).startOf('day').format('HH:mm')) ->
    moment().year(@year).dayOfYear(@day).hour(moment(label, 'HH:mm').hour()).startOf('hour')

  endDate: (label) ->
    if not label
      return @startDate(label).endOf('day')
    @startDate(label).endOf('hour')

  labels: ->
    return [0..@startDate().endOf('day').hours()].map (hour) =>
      @startDate().hour(hour).format('HH:mm') 

  data: (activities) =>
    sum = (total, value, index) =>
      total += value
      
    denomination = @denomination

    @labels().map (label) => 
      rangeBegin = @startDate(label)
      rangeEnd = @endDate(label)

      inRange = (activity) =>
        {start, end = moment()} = activity
        return (moment(rangeBegin).isBefore(moment(start)) and moment(rangeEnd).isAfter(moment(start))) or
          (moment(rangeBegin).isBefore(moment(end)) and moment(rangeEnd).isAfter(moment(end)))

      valuesInRange = activities.filter(inRange).map (activity) =>
        { start, end = moment() } = activity
        
        start = moment.max(moment(start), rangeBegin)
        end = moment.min(moment(end), rangeEnd)
        tmpStart = moment.min(start, end)
        tmpEnd = moment.max(start, end)
        start = tmpStart
        end = tmpEnd

        activityTime = moment.duration(end.diff(start)).as(denomination)
        return activityTime
      
      value = valuesInRange.reduce( sum, 0 )
      return value

@ChartByDay = ChartByDay