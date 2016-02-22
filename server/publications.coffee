Meteor.publish 'books', ->
  return Books.find({})

Meteor.publish 'bookshelf', ->
  return Bookshelf.find({})

Meteor.publish 'null', ->
  return Meteor.users.find({}, {fields: {username: 1}})
