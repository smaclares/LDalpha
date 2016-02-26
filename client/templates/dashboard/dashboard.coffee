Template.Dashboard.onCreated ->
  @subscribe 'books'
  @subscribe 'bookshelf'

Template.Dashboard.onRendered ->

  @autorun ->
    Library.bookInfo(0)

Template.Dashboard.helpers

  "oclc": () ->
    return Session.get('oclc')

  "title": () ->
    return Session.get('title')

  "author": () ->
    return Session.get('author')

  "misc1": () ->
    return Session.get('misc1')

  "misc2": () ->
    return Session.get('misc2')

  "misc3": () ->
    return Session.get('misc3')

  "image": () ->
    title = Session.get('title')
    return Library.getBookImage(title)

Template.Dashboard.events

  "click #prev": () ->
    Library.bookInfo(Library.paginate('prev'))

  "click #next": () ->
    Library.bookInfo(Library.paginate('next'))

  "click #users": () ->
    adminPass = prompt('Please enter the administrative password:')

    if adminPass == 'admin_pass'
      $('#users-modal').modal 'show'
    else
      alert 'Could not access admin control. Please, try again.'

  "click #log-out": () ->
    Meteor.logout (error) ->
      if error
        alert 'Could not log out! Please try again.'

  "click #your-account": () ->
    Modal.showModal 'Your Account:', 'Account'

  "click #help": () ->
    Modal.showModal 'Help:', 'Help'

  "click #add-to-bookshelf": () ->
    LibraryBookshelf.addBookToBookshelf()

  "click #download-bookshelf": () ->
    LibraryBookshelf.getPDF()

  "click #view-bookshelf": () ->
    Modal.showModal 'Your Bookshelf:', 'Bookshelf'

  "click #submit-sysnums": () ->
    sysnums = $('#sysnums-submissions').val().trim().split('\n')
    Library.addBookstoLibrary(sysnums)

  "click #clear-sysnums": () ->
    $('#sysnums-submissions').val('')

  "click #message-close": (event) ->
    $(event.currentTarget).closest('.message').transition('fade')
