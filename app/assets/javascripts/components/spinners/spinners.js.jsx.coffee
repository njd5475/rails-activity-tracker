
class Spinner extends React.Component

  render: () ->
    width = @props.width || '25px'
    height = @props.height || '25px'

    `<div style={{width, height}}>
      <div className="circle-spinner"></div>
    </div>`

@Spinner = Spinner