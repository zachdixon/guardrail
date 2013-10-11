CategoriesSC = new Meteor.SmartCollection("categoriesSC")

@Categories = new Meteor.Collection2 CategoriesSC,
	schema:
		app:
			type: String
		name:
			type: String