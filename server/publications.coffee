Meteor.publish 'books', ->
  Books.find {}

Meteor.publish 'bookshelf', ->
  Bookshelf.find {}

Meteor.publish 'notifications', ->
  Notification.find {}

Meteor.publish 'users', ->
  Meteor.users.find {}
