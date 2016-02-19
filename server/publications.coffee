Meteor.publish 'users', () ->
  return Meteor.users.find({})

Meteor.publish 'books', ->
  return Books.find({})

Meteor.publish 'bookshelf', ->
  return Bookshelf.find({})
