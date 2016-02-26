@Account = {
  changeUserName: (newUsername) ->

  changePassword: (newPassword) ->

  deleteAccount: (userId) ->
}


@LibraryBookshelf = {
  addBookToBookshelf: () ->
    data = $('.bib-info').text().trim().split('\n')
    user = Meteor.userId()

    Meteor.call 'addToBookshelf', data, user, (error) ->
      if error
        alert 'Could not add to bookshelf!'
        console.log error
      else
        title = data[1].replace('Title: ', '')
        $('.message').show().addClass('positive')
        $('#message-header').text('Success!')
        $('#message-text').text(title + ' was added to your bookshelf.')

  getBookshelfText: () ->
    return Bookshelf.find({}).fetch()

  getPDF: () ->
    doc = new jsPDF
    doc.setFontSize 9
    itemText = LibraryBookshelf.getBookshelfText()
    _.map itemText, (item) ->
      textdata = []
      _.map item, (i) ->
        if i != item._id and i != 'eng' and i != '' and String(i).indexOf('$') < 0 and String(i).indexOf('145') < 0
          textdata.push i
        return
      paragraphs = doc.splitTextToSize(textdata, 140)
      doc.text 30, 20, paragraphs
      doc.addPage()
      return
    doc.save 'bookshelf.pdf'
}

@Library = {
  addBookstoLibrary: (sysnums) ->
    Meteor.call 'addNewBooks', sysnums, (error) ->
      if error
        alert 'Could not download books!'
      else
        alert(sysnums.length + ' books have been uploaded!')
        $('#sysnums-submissions').val('')
      return

  bookInfo: (pgNum) ->
    Session.set 'pgNum', pgNum
    newBooks = Books.find({})
    newBooks.forEach (book, index) ->
      if index == pgNum
        Session.set 'oclc', book.oclc
        Session.set 'title', book.title
        Session.set 'author', book.author
        Session.set 'misc1', book.subjects
        Session.set 'misc2', book.pages
        Session.set 'misc3', book.year
      return

   getBookImage: (title) ->
      if title
        Meteor.call 'getBookImage', title, (error, response) ->
          if error
            Session.set('image', 'https://images.efollett.com/books/noBookImage.gif')
          else
            Session.set('image', response)
      return Session.get('image')

    paginate: (nav) ->
      limit = Books.find({}).count()
      pgNum = Session.get('pgNum')
      switch nav
        when 'prev'
          if pgNum > 0
            pgNum -= 1
            return pgNum
          else
            return 0
        when 'next'
          if pgNum < limit
            pgNum += 1
            return pgNum
          else
            return limit
        else
            return 0
      return

}

@Modal = {
  showModal: (title, template) ->
    Session.set('modalTitle', title)
    Session.set('modalTemplate', template)
    $('#main-modal').modal 'show'

}

@Patron = {
  createPatron: (username, password) ->

      if username && password

        Accounts.createUser {
          username: username
          password: password
        },  (error) ->
          if error
            alert 'Account creation failed! Please, try again or contact an Admin.'
            clearModal()
            return;

        alert 'Account creation successful! You may now log in.'

      else
        alert 'Invalid credentials. Please, try again.'
        clearModal()
        return;
}
