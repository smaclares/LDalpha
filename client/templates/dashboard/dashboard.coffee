Template.Dashboard.onCreated ->
  @subscribe 'books'
  @subscribe 'bookshelf'
  @subscribe 'notifications'
  @subscribe 'users'

Template.Dashboard.onRendered ->

  if Books
    Books.find({}).map (book) ->
      console.log book.title
      return


  $('.page').pagination
    items: ->
      Books.find({}).count()
    itemsOnPage: 1


  Session.setDefault 'pageNumber', 1

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

  "click #view-bookshelf": () ->
    $('#view-bookshelf-modal').modal('show')

  "click #submit-sysnums": () ->
    sysnums = $('#sysnums-submissions').val().trim().split('\n')
    console.log(sysnums)

    Meteor.call 'addNewBooks', sysnums, (error, response) ->
      if error
        alert 'Could not download books!'
      else
        alert(sysnums.length + ' books have been uploaded!')
        $('#sysnums-submissions').val('')
      return

  "click #clear-sysnums": () ->
    $('#sysnums-submissions').val('')

  "click .next": () ->

  "click .prev": () ->
