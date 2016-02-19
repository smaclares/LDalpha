Template.Dashboard.onCreated ->
  @subscribe 'books'
  @subscribe 'bookshelf'
  @subscribe 'notifications'
  @subscribe 'users'

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

getImage = (title) ->
  Meteor.call 'getImage', title, (error, response) ->
    if error
      return 'http://i.imgur.com/sJ3CT4V.gif'
    else
      return response


Template.Dashboard.onRendered ->

  @autorun ->
    getBookInfo 0

Template.Dashboard.helpers

  "image": () ->
    title = Session.get('title')
    if (title)
      return getImage(title)

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

Template.Dashboard.events

  "click #prev": () ->

    getBookInfo paginate('prev')

  "click #next": () ->

    getBookInfo paginate('next')

  "click #notifications": () ->
    $('#notifications-modal').modal 'show'

  "click #users": () ->
    $('#users-modal').modal 'show'

  "click #log-out": () ->
    alert 'Are you sure you want to log out?'

  "click #your-account": () ->
    $('#account-modal').modal 'show'

  "click #add-to-bookshelf": () ->
    data = $('.bib-info').text().trim().split('\n')

    Meteor.call 'addToBookshelf', data, (error) ->
      if error
        alert 'Could not add to bookshelf!'
      else
        title = data[1].replace('Title: ', '')
        $('.message').show().addClass('positive')
        $('#message-header').text('Success!')
        $('#message-text').text(title + ' was added to your bookshelf.')

  "click #download-bookshelf": () ->


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

  "click #clear-sysnums": () ->
    $('#sysnums-submissions').val('')

  "click #message-close": (event) ->
    $(event.currentTarget).closest('.message').transition('fade')
