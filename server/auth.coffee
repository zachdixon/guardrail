Meteor.startup ->
	WebApp.connectHandlers.stack.splice 0,0,
		route: ''
		handle: WebApp.__basicAuth__ (user, pass) ->
			'socialcompass' is user and 's0cialc0mpass' is pass