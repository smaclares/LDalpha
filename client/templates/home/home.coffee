Template.Home.onCreated ->
  @subscribe 'users'

Template.Home.events
  "click #sign-in": (event) ->

    username = $('[name="email"]').val();
    password = $('[name="password"]').val();

    if username && password
      Meteor.loginWithPassword username, password, (error) ->
          if Meteor.user()
            Router.go '/dashboard'
          else
            $('.ui.error.message').toggle('show').text(error.reason)

    else
      $('.ui.error.message').toggle('show').text('Invalid credentials. Please, try again.');


  "click #register": () ->
    Modal.showModal 'Register:', 'Register'
