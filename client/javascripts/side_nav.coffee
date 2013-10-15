Template.sideNav.helpers
	hasTests: ->
		Tests.find().count() > 0
	hasTestItems: ->
		Tests.find({category: @_id}).count() > 0
	categories: ->
		Categories.find()
	slug: ->
		_.slugify(@name)

Template.sideNav.rendered = ->
	$('.bs-sidenav').find('li:first').addClass 'active'