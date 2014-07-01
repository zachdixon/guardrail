@Tests = new Meteor.Collection("tests")

schema = new SimpleSchema
	app:
		type: String
	category:
		type: String
	description:
		type: String
	status:
		type: String
	title:
		type: String
	created_at:
		type: Date

@Tests.attachSchema(schema)

Meteor.methods
	'removeTest': (id) ->
		user = Meteor.user()
		throw new Meteor.Error(401, "Please login.") unless user
		test = Tests.findOne(id)
		throw new Meteor.Error(422, "Test not found") unless test
		Tests.remove id
