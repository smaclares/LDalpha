Meteor.publish 'books', ->
  return Books.find({})

Meteor.publish 'bookshelf', ->
  return Bookshelf.find({user_id: this.userId})

Meteor.publish 'null', ->
  return Meteor.users.find({}, {fields: {username: 1}})
