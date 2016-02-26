clearModal = ->
  $('[name="registration-code"]').val('')
  $('#username').val('')
  $('#password').val('')

Template.MainModal.helpers
  "modalTemplate": () ->
    return Session.get('modalTemplate')

  "modalTitle": () ->
    return Session.get('modalTitle')

 Template.Bookshelf.helpers
   'bookinfo': () ->
     return Bookshelf.find({})

 Template.Register.events

    "click #close": () ->
      $('#register-modal').modal 'hide'

    "click #complete-register": () ->

      accessCode = $('[name="registration-code"]').val()

      if accessCode == 'libraryStaff'
        username = $('#username').val()
        password = $('#password').val()

       Patron.createPatron(username, password)

      else
          alert 'Invalid access code. Please, try again.'
          clearModal()
