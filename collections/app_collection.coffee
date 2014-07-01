@Apps = new Meteor.Collection('apps')

schema = new SimpleSchema
	name:
		type: String

@Apps.attachSchema(schema)
