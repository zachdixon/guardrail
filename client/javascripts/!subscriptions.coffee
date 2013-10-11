@App = 
	subs: {}

App.subs.apps = Meteor.subscribe('apps')


Deps.autorun ->
	App.subs.categories = Meteor.subscribe('categories', Session.get('currentAppId'))
	App.subs.tests = Meteor.subscribe 'tests', Session.get('currentAppId'), Session.get('statusFilter'),
		onReady: ->
			Session.set('testsReady', true)
	App.subs.currentTest = Meteor.subscribe 'currentTest', Session.get('currentAppId'), Session.get('currentTest')