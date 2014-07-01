Handlebars.registerHelper 'with_index', (items) ->
	index = 1
	results = []
	items.forEach (item) ->
		item['index'] = index
		results.push(item)
		index++
	results

Handlebars.registerHelper 'currentApp', ->
	Session.get('currentApp')

Handlebars.registerHelper 'currentPage', (page) ->
	if Session.equals 'currentPage', page
		return 'active'
