Template.bugsList.helpers
  hasBugs: ->
    Bugs.find().count() > 0
  bugs: ->
    Bugs.find({}, {sort: {created_at: 1}})
