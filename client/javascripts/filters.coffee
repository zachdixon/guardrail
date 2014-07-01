Meteor.startup ->
	Session.setDefault 'statusFilter', 'all'
	Session.setDefault 'bugFilter', 'all'
	Session.setDefault 'bugTypeFilter', 'all'

Template.filters.helpers
	hasCategories: ->
		Categories.find().count() > 0
	currentFilter: (filter) ->
		Session.equals('statusFilter', filter)

Template.filters.events
	'click label': (e, doc) ->
		status = $(e.currentTarget).find('input').val()
		Session.set('statusFilter', status)

Template.bugFilters.helpers
	currentFilter: (filter) ->
		Session.equals('bugFilter', filter)

Template.bugFilters.events
	'click label.btn': (e, doc) ->
		status = $(e.currentTarget).find('input').val()
		Session.set('bugFilter', status)
	'change #bug-type-filter': (e, doc) ->
		type = $(e.currentTarget).val()
		Session.set('bugTypeFilter', type)
