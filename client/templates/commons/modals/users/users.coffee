Template.InnerUsers.events
  "click #delete-user": (e, template) ->

Template.InnerUsers.helpers
  "user": () ->
    usernames = []
    users = Meteor.users.find({})
    users.forEach (username) ->
      usernames.push username
    return usernames
