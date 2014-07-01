@Categories = new Meteor.Collection("categories")

schema = new SimpleSchema
	app:
		type: String
	name:
		type: String

@Categories.attachSchema(schema)
