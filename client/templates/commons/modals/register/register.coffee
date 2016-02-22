clearModal = ->
  $('[name="registration-code"]').val('')
  $('#username').val('')
  $('#password').val('')


Template.innerRegisterModal.events
  "click #close": () ->
    $('#register-modal').modal 'hide'

  "click #complete-register": () ->

    accessCode = $('[name="registration-code"]').val()

    if accessCode == 'libraryStaff'
      username = $('#username').val()
      password = $('#password').val()

      if username && password
        Accounts.createUser {
          username: username
          password: password
        },  (error) ->
          if error
            alert 'Account creation failed! Please, try again or contact an Admin.'
            clearModal()
      else
        alert 'Invalid credentials. Please, try again.'
        clearModal()
    else
      alert 'Invalid access code. Please, try again.'
      clearModal()

    alert 'Success! You may now log into your account.'
    $('#register-modal').modal 'hide'
