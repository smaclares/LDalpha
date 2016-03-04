Template.Dashboard.onCreated ->
  @subscribe 'books'
  @subscribe 'bookshelf'
  @subscribe 'directory'

Template.Dashboard.helpers

  "username": () ->
    return Meteor.user() && Meteor.user().username

Template.Dashboard.events

  "click #admin": () ->
    Modal.showModal 'Admin:', 'Admin'

  "click #users": () ->
    Modal.showModal 'Users:', 'Users'

  "click #log-out": () ->
    Meteor.logout (error) ->
      if error
        alert 'Could not log out! Please try again.'

  "click #your-account": () ->
    Modal.showModal 'Your Account:', 'Account'

  "click #notifications": () ->
    Modal.showModal 'Notifications:', 'Notifications'

  "click #help": () ->
    Modal.showModal 'Help:', 'Help'
