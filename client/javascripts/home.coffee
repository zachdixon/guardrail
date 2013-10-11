Template.apps.helpers
	apps: ->
		Apps.find()

Template.home.events
	'submit #addApp': (e, doc) ->
		e.preventDefault()
		app =
			name: $(e.target).find('#newApp').val()
		Apps.insert(app)
		$('#newApp').val("")

Template.app.helpers
	testCount: ->
		# FIXME: Add count to app table
		Tests.find({app: @_id}).count()

Template.app.events
	'click .delete': (e, doc) ->
		e.preventDefault()
		if confirm("Are you sure? This will delete the entire app along with any categories and tests that belong to it.")
			App.remove(@_id)
			# FIXME: Remove all categories and tests by app id, must move this to Meteor.methods
			# Categories.remove(@_id)
			# Tests.find({category: @_id}).forEach (test) ->
			# 	Tests.remove(test._id)