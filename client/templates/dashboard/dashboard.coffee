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

  "click #clear-sysnums": () ->
    $('#sysnums-submissions').val('')
