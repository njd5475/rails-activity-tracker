
class ChartByWeek extends ChartAggregator
  constructor: (dataset, week, denomination = 'hours') ->
    super(dataset)
    @week = week
    @year = moment().year()
    @denomination = denomination

  datasetLabel: =>
    "Week #{@startDate().week()} of #{@startDate().year()} ending #{@endDate().format('MMM DD, YYYY')}"
  
  next: ->
    @week += 1
    @week = Math.min(moment().year(@year).weeksInYear(), @week)

  previous: ->
    @week -= 1
    @week = Math.max(0, @week)

  startDate: (label = moment().year(@year).week(@week).startOf('week').format('dddd')) ->
    moment().year(@year).week(@week).day(label).startOf('day')

  endDate: (label) ->
    if not label
      return @startDate(label).endOf('isoWeek')
    @startDate(label).endOf('day')

  labels: ->
    return moment.weekdays()
  
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

@ChartByWeek = ChartByWeek