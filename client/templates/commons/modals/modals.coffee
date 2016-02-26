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
