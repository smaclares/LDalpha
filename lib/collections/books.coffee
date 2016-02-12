@Books = new Mongo.Collection('books')
@Pages = new Meteor.Pagination Books,
  perPage: 1
  sort: title: 1
  availableSettings:
    perPage: true
    sort: true

Pages.set
  perPage: 1
  sort: title: 1
