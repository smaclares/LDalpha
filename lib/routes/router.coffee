Router.route '/', ->
  @render 'Home'
  return
  
Router.route '/dashboard',
  waitOn: ->
    [
      Meteor.subscribe('users')
      Meteor.subscribe('books')
      Meteor.subscribe('bookshelf')
    ]
  action: ->
    if @ready()
      @render 'Dashboard'
      @next()
    return
