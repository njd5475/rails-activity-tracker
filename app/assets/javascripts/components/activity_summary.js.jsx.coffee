#= require underscore
#= require moment

class ActivitySummary extends React.Component
  constructor: (props) ->
    @state = {
      summary: @summarize(props.activities)
    }

  summarize: (activities) ->
    m = {}

    r = (m, a) ->
      last = 0
      last = m[a.description] if m[a.description]?
      m[a.description] = last + moment(a.end).diff(moment(a.start))
      return m

    m = _.reduce activities, r, {}

    m = _.map m, (v, k) ->
      `<ActivityTotal title={k} time={v} />`

    return m

  render: ->

    `<div className="row">
      <h2>Summary</h2>
      {this.state.summary}
    </div>`


@ActivitySummary = ActivitySummary
