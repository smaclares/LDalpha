Router.configure layoutTemplate: 'Main'

Router.onBeforeAction ->
  if !Meteor.userId()
    @render 'Home'
  else
    @next()
  return

Router.route '/', ->
  @render 'Home'
  return

Router.route '/dashboard', ->
  @render 'Dashboard'
  return
