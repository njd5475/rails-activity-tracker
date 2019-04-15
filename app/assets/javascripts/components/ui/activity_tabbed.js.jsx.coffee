
class ActivityTabbed extends React.Component
	constructor: (props) ->
		@tabs = props.tabs
		@state = 
			current: @tabs[0]

	render: =>
		current = @state.current
		links = @tabs.map (t) =>
			active = t.name == current.name
			name = t.name.replace(/\s+/, '-')
			data = 
				toggle: 'tab'
			aria = 
				'aria-controls': "#{name}-tab"
				'aria-selected': 'true'
			hrefStr = "##{name}"
			classes = ['nav-link']
			classes.push('active') if active
			navClick = (e) =>
				@setState(
					current: t
				)
				e.preventDefault()

				false

			el = `<a className={classes.join(' ')}
				id={name + "-tab"}
				{...data}
				href={hrefStr}
				role="tab"
				onClick={navClick}
				{...aria} >
				{t.name}
				</a>`

			liClasses = []
			liClasses.push('active') if active

			`<li key={name} className={liClasses}>
				{el}
			</li>`

		components = @tabs.map (t) ->
			name = t.name.replace(/\s+/, '-')
			accessibility = 
				'aria-labelledby': "#{name}-tab"
			classes = ['tab-pane', 'fade']
			classes.push('active in') if t.name == current.name
			`<div 
				className={classes.join(' ')}
				id={name} 
				role="tabpanel" 
				{...accessibility}
				key={name} >
				{t.component}
			</div>`

		`<div>
			<ul className="nav nav-tabs" id="myTab" role="tablist">
				{links}
			</ul>

			<div className="tab-content" id="myTabContent">
				{components}
			</div>
		</div>`

@ActivityTabbed = ActivityTabbed
