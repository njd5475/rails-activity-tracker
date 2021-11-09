
class ChartByYear extends ChartAggregator
  constructor: (dataset, year, denomination = 'hour') ->
    super(dataset)
    @year = year
    @denomination = denomination

  datasetLabel: =>
    "#{@startDate().year().toString()}"

  next: ->
    @year += 1
    @year = Math.min(moment().year()+1, @year)

  previous: ->
    @year -= 1
    @year = Math.max(0, @year)

  startDate: (label = moment().year(@year).startOf('year').format('MMMM')) ->
    moment().year(@year).month(label).startOf('month')

  endDate: (label) ->
    @startDate(label).endOf('month')

  labels: ->
    return moment.months()
  
  data: (activities) ->
    sum = (total, value, index) =>
      total += value
      total

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
      
      value = valuesInRange.reduce( sum, 0 )
      return value
    
@ChartByYear = ChartByYear