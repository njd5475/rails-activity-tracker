#= require_tree ./date

class ActivityCharts extends React.Component

  constructor: (props) ->
    year = moment().year()

    @state = 
      chart: new ChartByMonth('Total', moment().month())
      page: 0
      dataset: 'Total'
      agg: 'month'
      charts:
        'day': ChartByDay
        'week': ChartByWeek
        'month': ChartByMonth
        'year': ChartByYear

  componentDidMount: ->
    @changeChart()

  changeChart: ->
    @chartObj.destroy() if @chartObj?.destroy

    chart = @state.chart
    labels = chart.labels()
    
    data = 
      labels: labels
      datasets: chart.datasets(@props.activities)
    
    config =
      type: 'bar'
      options: {
        scales:
          y:
            beginAtZero: true
        
        onClick: (e, chart) -> 
          chart = chart[0]._chart
          canvasPosition = Chart.helpers.getRelativePosition(e, chart)

          # Substitute the appropriate scale IDs
          dataX = chart.scales['x-axis-0'].getValueForPixel(canvasPosition.x)
          dataY = chart.scales['y-axis-0'].getValueForPixel(canvasPosition.y)
          
          label = labels[dataX]

          return label
      }
      data: data

    @chartObj = new Chart($(@chart)[0], config)

  byChange: (c) =>
    agg = c.target.value
    @changeTimeAgg(agg)

  changeTimeAgg: (agg) =>
    newChart = @state.chart
    if agg == 'day'
      newChart = new ChartByDay(@state.dataset, moment().dayOfYear())
    if agg == 'week'
      newChart = new ChartByWeek(@state.dataset, moment().week())
    else if agg == 'year'
      newChart = new ChartByYear(@state.dataset, moment().year())
    else if agg == 'month'
      newChart = new ChartByMonth(@state.dataset, moment().month())

    @setState({
      agg: agg
      chart: newChart
    }, => @changeChart())

  datasetChange: (c) =>
    newDataSet = c.target.value
    @setState({
      dataset: newDataSet
    }, => @changeTimeAgg(@state.agg))

  next: =>
    @state.chart.next()

    @setState({
      page: @state.page + 1
    }, => @changeChart())

  previous: =>
    @state.chart.previous()

    @setState({
      page: @state.page + 1
    }, => @changeChart())

  render: =>
    size =
      maxHeight: '600px'

    fn = @byChange

    options = `
      <select defaultValue="month" onChange={fn}>{
        [ 
          <option key={1} value="day">By Day</option>,
          <option key={2} value="week">By Week</option>,
          <option key={3} value="month">By Month</option>,
          <option key={4} value="year">By Year</option>,
        ]  
      }</select>`

    datasetChange = @datasetChange
    datasetOptions = `
      <select defaultValue="Total" onChange={datasetChange}>{
        [
          <option key={1} value="Total">Total</option>,
          <option key={2} value="goal">By Goal</option>,
          <option key={3} value="activity">By Activity</option>,
        ]
      }</select>
      `

    `<div>
      {datasetOptions}
      {'\n'}
      {options}
      {'\n'}
      <button onClick={this.previous}><i className="glyphicon glyphicon-chevron-left" />Previous</button>
      {'\n'}
      <button onClick={this.next}>Next<i className="glyphicon glyphicon-chevron-right" /></button>
      {'\n'}
      <canvas ref={ref => this.chart = ref} height={100}/>
    </div>`

@ActivityCharts = ActivityCharts