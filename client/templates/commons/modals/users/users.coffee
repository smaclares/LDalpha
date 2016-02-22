Template.Users.helpers
  "user": () ->
    usernames = []
    users = Meteor.users.find({})
    users.forEach (username) ->
      usernames.push username
    return usernames
