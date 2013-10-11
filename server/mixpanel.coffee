Meteor.methods
  trackUser: ->
    person =
      "$email": Meteor.user().emails[0].address
      "$username": Meteor.user().username
      "$name": Meteor.user().username
      "$created": new Date(Meteor.user().createdAt)
