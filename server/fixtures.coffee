Meteor.startup ->
  if Books.find({}).count() == 0
    defaultSysnums = ['002543090', '001883918', '002300510']
