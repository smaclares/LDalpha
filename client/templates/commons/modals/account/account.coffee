Template.Account.helpers
  'displayUsername': ()->
    return Meteor.user().username

Template.Account.events
  'click #change-username': () ->

    newUsername = prompt "Please enter your new username:"

    if newUsername
      Meteor.call 'updateUsername', newUsername, (error) ->
        if error
          alert "Sorry, we cannot update your username at this time."

  'click #change-password': () ->

    confirmPassword = prompt "Please enter your old password:"

    if confirmPassword == Meteor.user().password
      newPassword = prompt "Please enter a new password:"

    if newPassword
        Meteor.call 'updatePassword', newPassword, (error) ->
          if error
            alert  "Sorry, we cannot update your password at this time."

  'click #delete-account': () ->
    confirmDelete = confirm('Are you sure you want to delete your account?')

    if confirmDelete
      Meteor.call 'deleteUser', Meteor.user().username, (error) ->
        if error
          alert( "Sorry, we cannot delete your account at this time. Please,
          try again or contact an admin.")
