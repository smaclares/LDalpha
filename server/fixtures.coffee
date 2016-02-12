Meteor.startup ->
  if Books.find.count() === 0
    defaultSysnums = []
