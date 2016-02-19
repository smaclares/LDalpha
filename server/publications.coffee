Meteor.publish 'books', ->
<<<<<<< HEAD
  Books.find {}

Meteor.publish 'bookshelf', ->
  Bookshelf.find {}

Meteor.publish 'notifications', ->
  Notification.find {}

Meteor.publish 'users', ->
  Meteor.users.find {}
=======
  return Books.find({})

Meteor.publish 'bookshelf', ->
  return Bookshelf.find({})
>>>>>>> origin/master
