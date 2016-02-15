Template.Dashboard.onCreated ->
  @subscribe 'books'
  @subscribe 'bookshelf'
  @subscribe 'notifications'
  @subscribe 'users'

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

    Meteor.call 'addNewBooks', sysnums, (error, response) ->
      if error
        alert 'Could not download books!'
      else
        $('#sucess').toggleClass('hidden')
        $('#success').text(sysnums.length + ' books have been uploaded!')
        $('#input-sys-nums').val('')
      return

  "click #clear-sysnums": () ->
    $('#sysnums-submissions').val('')
