
class ActivityTabbed extends React.Component
	constructor: (props) ->
		@state = 
			current: props.tabs[0]
	
	updateMe: =>
		@setState update: @state.update + 1

	componentDidMount: =>
		@switchTabs(location.hash)

		window.addEventListener("hashchange", @switchTabsHandler)

	switchTabsHandler: (event) =>
		@switchTabs(location.hash)

	switchTabs: (hash) =>
		if hash
			tabLink = document.querySelector('a[href="' + hash + '"]')
			if !tabLink
				return false

			tabLink.click()
			
			setTimeout((=> window.scrollTo(0, 0)), 1) if hash

	render: =>
		current = @state.current
		updates = @state.update
		links = @props.tabs.map (t, i) =>
			active = t.name == current.name
			name = t.name.replace(/\s+/, '-')
			data = 
				toggle: 'tab'
			aria = 
				'aria-controls': "#{name}-tab"
				'aria-selected': 'true'
			hrefStr = "##{name}".toLowerCase()
			classes = ['nav-link']
			classes.push('active') if active
			navClick = (e) =>
				@setState current: t

				location.hash = "#{hrefStr}"
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

			`<li key={i} className={liClasses}>
				{el}
			</li>`

		components = @props.tabs.map (t, i) ->
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
				key={i} >
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
