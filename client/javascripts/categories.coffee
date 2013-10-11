Template.categoriesList.events
	'submit #addCategory': (e, doc) ->
		e.preventDefault()
		category =
			app: Session.get('currentAppId')
			name: $(e.target).find('#newCategory').val().toLowerCase()
		Categories.insert(category)
		$('#newCategory').val("")


Template.categories.helpers
	categories: ->
		Categories.find()

Template.category.events
	'click .delete': (e, doc) ->
		e.preventDefault()
		if confirm("Are you sure? This will delete the category and any tests that belong to it.")
			Categories.remove(@_id)
			Tests.find({category: @_id}).forEach (test) ->
				Tests.remove(test._id)

Template.categories.rendered = ->
	$('.list-group').editable
		selector: '.editable-click'
		type: 'text'
		mode: 'inline'
	$('a.category-name').unbind('save').on 'save', (e, params) ->
		id = @id
		oldCategory = @text
		newCategory = params.newValue
		# TODO: move to Meteor.methods once security is implemented
		# Tests.update({category: oldCategory}, {$set: {category: newCategory}})
		Categories.update(id, {$set: {name: newCategory}})