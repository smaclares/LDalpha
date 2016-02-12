Meteor.methods

  "addNewBooks": (sysnums) ->

    urls = []
    _.map sysnums, (num) ->
      url = 'http://discover.linccweb.org/PrimoWebServices/' +
      'xservice/search/full?institution=FLCC1900&docId=ccla_aleph' + num
      urls.push url
      return

    _.map urls, (url, index) ->
      HTTP.call 'GET', url, (error, results) ->

        if error
          console.log error
        else
          data = results.content.replace(/<\/?[^>]+>/gi, '').split('\n')
          data = data.slice(18, 38)
          i = 0

          while i < data.length
            if data[i].indexOf('$') > -1
              x = data.indexOf(data[i])
              data.splice x, 1

          if data[i] != undefined
            data[i] = data[i].trim()

          flccrem = data.indexOf('ccla_aleph')
          data.splice flccrem, 5

          Books.insert
            oclc: sysnums[index]
            title: data[0]
            author: data[1]
            extauthor: data[2]
            edition: data[3]
            publisher: data[4]
            year: data[5]
            pages: data[6]
            subjects: data[7]
            description: data[8]
            extdescription: data[9]

    "deleteUser": (userId) ->

    "getBookImage": (title) ->

    "inviteUser": (email) ->

    "removeFromBookshelf" : (title) ->
