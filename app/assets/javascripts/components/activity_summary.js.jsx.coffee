#= require underscore

class ActivitySummary extends React.Component
  constructor: (props) ->
    @state = {
      summary: @summarize(props.activities)
    }

  summarize: (activities) =>
    m = {}

    r = (m, a) ->
      last = 0
      last = m[a.description] if m[a.description]?
      m[a.description] = last + moment(a.end).diff(moment(a.start))
      m.time_diff = moment(a.end).diff(moment(a.start))
      return m

    agg = _.reduce activities, r, {}

    m = Object.entries(agg).sort (l, r) ->
      return r[1] - l[1]

    i = 0

    m = _.map m, ([v, k]) ->
      `<ActivityTotal key={++i} title={v} time={k} />`

    return m

  render: =>

    `<div className="row">
      <div className="col-md-12">
        <h3>Summary</h3>
        {this.state.summary}
      </div>
    </div>`


@ActivitySummary = ActivitySummary
