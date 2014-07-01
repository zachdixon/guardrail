@Bugs = new Meteor.Collection("bugs")

schema = new SimpleSchema
  app:
    type: String
  bug_type:
    type: String
  urgency:
    type: Number
  description:
    type: String
  browser:
    type: String
  browser_version:
    type: Number
  status:
    type: String
  title:
    type: String
  vote_count:
    type: Number
  created_by_user_id:
    type: String
  created_by_username:
    type: String
  created_at:
    type: Date

@Bugs.attachSchema(schema)

Meteor.methods
  'removeBug': (id) ->
    user = Meteor.user()
    throw new Meteor.Error(401, "Please login.") unless user
    test = Bugs.findOne(id)
    throw new Meteor.Error(422, "Bug not found") unless test
    Bugs.remove id
