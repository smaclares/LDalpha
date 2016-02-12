Router.map ->
  @route 'Home',
    path: '/'
    waitOn: ->
      Meteor.subscribe 'users'
  @route 'Dashboard', path: '/dashboard'
