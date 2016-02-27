Meteor.startup ->
  if Books.find({}).count() == 0
    defaultSysnums = ['002543090', '001883918', '002300510']
    Meteor.call 'addNewBooks', defaultSysnums, (error) ->
      if error
        alert 'Could not download books!'

admin = Meteor.users.findOne({username: 'maclares@palmbeachstate.edu'})._id;
Roles.addUsersToRoles(admin, ['admin']);
