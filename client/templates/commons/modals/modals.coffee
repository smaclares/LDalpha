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
      Patron.registerPatron()

Template.Account.events

  "click #change-username": () ->
    Account.changeUserInfo('username')

  "click #change-password": () ->
    Account.changeUserInfo('password')


Template.Admin.events

    "click #log-in-as-admin": () ->
      Admin.logInAdmin()
