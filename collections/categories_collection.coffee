@Categories = new Meteor.Collection("categories")

schema = new SimpleSchema
	app:
		type: String
	name:
		type: String

@Categories.attachSchema(schema)

Meteor.methods
	'removeCategory': (id) ->
		user = Meteor.user()
		throw new Meteor.Error(401, "Please login.") unless user
		test = Categories.findOne(id)
		throw new Meteor.Error(422, "Test not found") unless test
		Categories.remove id
