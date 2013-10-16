Template.header.helpers
	apps: ->
		Apps.find({_id: {$ne: Session.get('currentAppId')}}, {sort: {name: 1}})
	multipleApps: ->
		Apps.find({_id: {$ne: Session.get('currentAppId')}}, {sort: {name: 1}}).count() > 0