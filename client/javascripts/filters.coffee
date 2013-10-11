Meteor.startup ->
	Session.setDefault 'statusFilter', 'all'

Template.filters.helpers
	hasCategories: ->
		Categories.find().count() > 0
	currentFilter: (filter) ->
		Session.equals('statusFilter', filter)

Template.filters.events
	'click label': (e, doc) ->
		status = $(e.currentTarget).find('input').val()
		Session.set('statusFilter', status)