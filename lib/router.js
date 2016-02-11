Router.configure({
  layoutTemplate: 'Main'
});

Router.onBeforeAction(function(){
  if (!Meteor.userId()){
    this.render('LoginMessage', {to: 'message'});
    this.render('HomeNav', {to: 'nav'});
    this.render('Home');
  }
});

Router.route('/', function(){
  this.render('HomeNav', {to: 'nav'})
  this.render('Home');
});

Router.route('/dashboard', function(){
  this.render('DashboardNav', {to: 'nav'});
  this.render('Dashboard');
});
