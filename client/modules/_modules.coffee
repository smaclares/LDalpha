@Account = {

  changeUserInfo: (data) ->

    switch data
      when 'username'
        newUsername = prompt('Please, enter your new username: ')

        if newUsername
          Meteor.user().username = newUsername
          Message.displayMessage('Your username has been changed.', 'positive', 'modal')
        else
          Message.displayMessage('Could not change username! Please, try again.', 'negative', 'modal')

      when 'password'
        newPassword = prompt('Please, enter your new password: ')

        if newPassword
          Meteor.user().password = newPassword
          Message.displayMessage('Your password has been changed.', 'positive', 'modal')
        else
          Message.displayMessage('Invalid input! Please, try again.', 'negative', 'modal')

  deleteAccount: (user) ->
    Meteor.call 'deleteUser', user, (error) ->
      if error
        Message.displayMessage('Could not delete account! Please, try again.', 'negative', 'modal')

  helpRequest: (text) ->
    Meteor.call 'sendEmail', text (error) ->
      if error
        Message.displayMessage('Could not send help request! Please, try again.', 'negative', 'modal')

}

@Admin = {

  logInAdmin: () ->
    username = $('#admin-username').val()
    password = $('#admin-password').val()

    if username && password

      if username == 'admin' && password == 'admin'
        Meteor.call 'addAdminRole', Meteor.userId(), (error) ->
          if error
            Message.displayMessage('Could not log in as admin!', 'negative', 'modal')
          else
            alert 'You are now logged in as an admin.'
            $('#main-modal').modal 'hide'
      else
        Message.displayMessage('Credentials not valid. Please, try again.', 'negative', 'modal')
    else
      Message.displayMessage('Username or password were invalid. Please, try again.', 'negative', 'modal')
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

  deleteBookFromBookshelf: (title) ->
    Meteor.call 'deleteBook', title, 'Bookshelf', (error) ->
      Message.displayMessage('Could not delete from bookshelf!', 'negative', 'modal')

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

  deleteBook: (title, db) ->
    Meteor.call 'deleteBook', title, db, (error) ->
      if error
        alert 'Could not delete book!'
      else
        alert title + ' has been deleted.'

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
            if $.isNumeric(nav) && nav < limit && nav > 0
              pgNum = nav
              return pgNum
            else
              return 0
      return

    search: (num) ->

      key = false;
      i = 0;
      searchItems = Books.find({})
      searchItems.forEach (book, index) ->
        if num == book.oclc
          key = true;
          i = index;

      if key == true
        Library.bookInfo(Library.paginate(i))
      else
        alert 'Book not found.'


    searchGoogle: (title) ->
      title = title.replace(/\s+/g, '+')
      window.open('https://www.google.com/?gws_rd=ssl#q=' + title, '_blank')
}

@Modal = {

  clearRegisterModal: () ->
    $('[name="registration-code"]').val('')
    $('#username').val('')
    $('#password').val('')

  showModal: (title, template) ->
    Session.set('modalTitle', title)
    Session.set('modalTemplate', template)
    $('#main-modal').modal 'show'
}

@Message = {
  displayMessage: (text, status, template) ->
    switch template
      when 'modal'
        $('#modal-message').show().addClass(status).text(text)
}

@Patron = {
  createPatron: (username, password) ->

    if username && password
      if username.includes('@palmbeachstate.edu')
        if password.length >= 7
            Accounts.createUser {
            username: username
            password: password
              }, (error) ->
                if error
                  Message.displayMessage('Account creation failed! Please, try again or contact an Admin.', 'negative', 'modal')
                  Modal.clearRegisterModal()
                  return;
                else
                  $('#main-modal').modal 'hide'
                  alert 'Account creation successful!'
                  Router.go '/dashboard'
          else
            Message.displayMessage('Password must have more than seven characters.', 'negative', 'modal')
            Modal.clearRegisterModal()
       else
         Message.displayMessage('User email must be from @palmbeachstate.edu. Please, try again.', 'negative', 'modal')
         Modal.clearRegisterModal()
    else
        Message.displayMessage('Invalid credentials. Please, try again!', 'negative', 'modal')
        Modal.clearRegisterModal()

  registerPatron: () ->

      accessCode = $('[name="registration-code"]').val()

      if accessCode == 'libraryStaff'
        username = $('#username').val()
        password = $('#password').val()

        Patron.createPatron(username, password)

      else
          displayMessage('Invalid access code. Please, try again.', 'negative', 'modal')
}
