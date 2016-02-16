Template.Dashboard.onCreated ->
  @subscribe 'books'
  @subscribe 'bookshelf'
  @subscribe 'notifications'
  @subscribe 'users'

getBookInfo = (pgNum) ->
  newBooks = Books.find({})
  newBooks.forEach (book, index) ->
    if index == pgNum
      Session.set 'oclc', book.oclc
      Session.set 'title', book.title
      Session.set 'author', book.author
    return
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

Template.Dashboard.events

  "click #notifications": () ->
    $('#notifications-modal').modal('show')

  "click #users": () ->
    $('#users-modal').modal('show')

  "click #log-out": () ->
    alert 'Are you sure you want to log out?'

  "click #your-account": () ->
    $('#account-modal').modal('show')

  "click #add-to-bookshelf": () ->

  "click #download-bookshelf": () ->
      newBooks = Books.find({})
      newBooks.forEach (book) ->
        console.log book.title
        return

  "click #view-bookshelf": () ->
    $('#view-bookshelf-modal').modal('show')

  "click #submit-sysnums": () ->
    sysnums = $('#sysnums-submissions').val().trim().split('\n')

    Meteor.call 'addNewBooks', sysnums, (error, response) ->
      if error
        alert 'Could not download books!'
      else
        alert(sysnums.length + ' books have been uploaded!')
        $('#sysnums-submissions').val('')
      return

  "click #clear-sysnums": () ->
    $('#sysnums-submissions').val('')
