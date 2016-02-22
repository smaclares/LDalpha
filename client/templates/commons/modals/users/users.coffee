Template.InnerUsers.events
  "click #delete-user": () ->
    userID = this._id
    Meteor.call 'deleteUser', userID, (error) ->
      if error
        alert 'Could not delete account! Please, try again.'
      else
        alert 'Account successfully deleted.'

Template.InnerUsers.helpers
  "user": () ->
    usernames = []
    users = Meteor.users.find({})
    users.forEach (username) ->
      usernames.push username
    return usernames
