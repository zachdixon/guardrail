AppsSC = new Meteor.SmartCollection('appsSC')

@Apps = new Meteor.Collection2 AppsSC,
	schema:
		name:
			type: String