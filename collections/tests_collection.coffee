TestsSC = new Meteor.SmartCollection("testsSC")

@Tests = new Meteor.Collection2 TestsSC,
	schema:
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