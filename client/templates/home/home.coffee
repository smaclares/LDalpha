Template.Home.events
  "click #sign-in": (event) ->

    username = $('[name="email"]').val();
    password = $('[name="password"]').val();

    if username && password
      Meteor.loginWithPassword username, password, (error) ->
          if error
              $('.ui.error.message').toggle('show').text('User not found. Please try again.')
          else
              Router.go '/dashboard'

    else
      $('.ui.error.message').toggle('show').text('Invalid credentials. Please, try again.');


  "click #register": () ->
    $('#register-modal').modal('show')
