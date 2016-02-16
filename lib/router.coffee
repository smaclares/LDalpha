Router.configure layoutTemplate: 'Main'

Router.route '/', ->
  @render 'Home'
  return

Router.route '/dashboard', ->
  @render 'Dashboard'
  return
