Template.NewBooks.onRendered ->
    @autorun ->
      Library.bookInfo(0)

Template.NewBooks.helpers
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

Template.NewBooks.events

  "click #prev": () ->
      Library.bookInfo(Library.paginate('prev'))

  "click #next": () ->
      Library.bookInfo(Library.paginate('next'))

  "click #google-img": () ->
    title = Session.get('title')
    Library.searchGoogle(title)

  "click #delete-book": () ->
    title = Session.get('title')
    Library.deleteBook(title, 'Books')

  "click #add-to-bookshelf": () ->
    LibraryBookshelf.addBookToBookshelf()

  "click #download-bookshelf": () ->
    LibraryBookshelf.getPDF()

  "click #view-bookshelf": () ->
    Modal.showModal 'Your Bookshelf:', 'Bookshelf'

  "click #search-button": () ->
    oclcnum = $('#search-input').val()
    Library.search(oclcnum)
    $('#search-input').val(' ')

  "click #admin-add-books": () ->
    $('#add-new-books').show()

  "click #submit-sysnums": () ->
    sysnums = $('#sysnums-submissions').val().trim().split('\n')
    Library.addBookstoLibrary(sysnums)

  "click #clear-sysnums": () ->
    $('#sysnums-submissions').val('')

  "click #message-close": (event) ->
    $(event.currentTarget).closest('.message').transition('fade')
