Meteor.publish 'apps', ->
	Apps.find({}, {sort: {name: 1}})

Meteor.publish 'tests', (app, status) ->
	if status is "all"
		return Tests.find({app: app}, {sort: {position: 1}})
	else
		return Tests.find({app: app, status: status}, {sort: {position: 1}})

Meteor.publish 'currentTest', (app, id) ->
	Tests.find({_id: id, app: app})

Meteor.publish 'categories', (app) ->
	Categories.find({app: app}, {sort: {name: 1}})

Meteor.publish 'bugs', (app, status, type) ->
	options = {}
	options.app = app
	unless status is "all" then options.status = status
	unless type is "all" then options.type = type
	return Bugs.find(options, {sort: {created_at: 1}})
