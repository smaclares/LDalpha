Template.Dashboard.onCreated ->
  @subscribe 'books'
  @subscribe 'bookshelf'

getBookInfo = (pgNum) ->
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
  return

paginate = (nav) ->
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

Template.Dashboard.onRendered ->

  @autorun ->
    getBookInfo 0


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
    if title
      Meteor.call 'getBookImage', title, (error, response) ->
        if error
          Session.set('image', 'https://images.efollett.com/books/noBookImage.gif')
        else
          Session.set('image', response)
    return Session.get('image')

Template.Dashboard.events

  "click #prev": () ->

    getBookInfo paginate('prev')

  "click #next": () ->

    getBookInfo paginate('next')

  "click #notifications": () ->
    $('#notifications-modal').modal 'show'

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
    $('#account-modal').modal 'show'

  "click #add-to-bookshelf": () ->
    data = $('.bib-info').text().trim().split('\n')

    Meteor.call 'addToBookshelf', data, (error) ->
      if error
        alert 'Could not add to bookshelf!'
        console.log error
      else
        title = data[1].replace('Title: ', '')
        $('.message').show().addClass('positive')
        $('#message-header').text('Success!')
        $('#message-text').text(title + ' was added to your bookshelf.')

  "click #download-bookshelf": () ->
    doc = new jsPDF
    doc.setFontSize 9
    itemText = Bookshelf.find({}).fetch()
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

  "click #view-bookshelf": () ->
    $('#view-bookshelf-modal').modal 'show'

  "click #submit-sysnums": () ->
    sysnums = $('#sysnums-submissions').val().trim().split('\n')

    Meteor.call 'addNewBooks', sysnums, (error) ->
      if error
        alert 'Could not download books!'
      else
        alert(sysnums.length + ' books have been uploaded!')
        $('#sysnums-submissions').val('')
      return

    $('#sysnums-submissions').val ''

  "click #clear-sysnums": () ->
    $('#sysnums-submissions').val('')

  "click #message-close": (event) ->
    $(event.currentTarget).closest('.message').transition('fade')
