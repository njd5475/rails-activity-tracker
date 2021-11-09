
class ChartByMonth extends ChartAggregator
  constructor: (dataset, month, year = moment().year(), denomination = 'hour') ->
    super(dataset)
    @month = month
    @year = year
    @denomination = denomination

  datasetLabel: =>
    "#{@startDate().format('MMMM').toString()}, #{@startDate().year()}"

  next: ->
    @month += 1
    @month = Math.min(12, @month)

  previous: ->
    @month -= 1
    @month = Math.max(0, @month)

  startDate: (label = moment().year(@year).month(@month).startOf('month').format('dddd D')) ->
    moment().year(@year).month(@month).date(Number.parseInt(label.slice(label.length-2))).startOf('day')

  endDate: (label) ->
    @startDate(label).endOf('day')

  labels: ->
    num = Number.parseInt(@startDate().daysInMonth())
    lbls = [0..num].map (num) => @startDate().date(num).format('dddd D')

    lbls

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
    

@ChartByMonth = ChartByMonth