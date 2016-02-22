Meteor.methods

  'addNewBooks': (sysnums) ->

    urls = []

    _.map sysnums, (num) ->
      url = 'http://discover.linccweb.org/PrimoWebServices/' + 'xservice/search/full?institution=FLCC1900&docId=ccla_aleph' + num
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
            i++

          flccrem = data.indexOf('ccla_aleph')
          data.splice flccrem, 5

          oclc = sysnums[index]
          title = data[0]
          author = data[1]
          extendedAuthor = data[2]
          edition = data[3]
          publisher = data[4]
          year = data[5]
          pages = data[6]
          subjects = data[7]
          description = data[8]
          extendedDescription = data[9]


          Books.insert
            oclc: oclc
            title: title
            author: author
            extauthor: extendedAuthor
            edition: edition
            publisher: publisher
            year: year
            pages: pages
            subjects: subjects
            description: description
            extdescription: extendedDescription
        return
      return
    return

  'addToBookshelf': (data) ->

    oclc = data[0]
    title = data[1]
    author = data[2]
    misc1 = data[5]
    misc2 = data[6]
    misc3 = data[7]

    Bookshelf.insert
      oclc: oclc
      title: title
      author: author
      misc1: misc1
      misc2: misc2
      misc3: misc3

  'deleteUser': (userID) ->
    Meteor.users().remove { _id: userID }, (error) ->
      if error
        return error
      return

  'getBookImage': (title) ->

    if title
      title = title.replace(/\s+/g, '+')
      cheerio = Meteor.npmRequire('cheerio')
      url = 'http://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords=' + title
      result = Meteor.http.get(url)

    if result
      $ = cheerio.load(result.content)
      imgsrc = $('.s-access-image.cfMarker').attr('src')
      return imgsrc

    'removeFromBookshelf' : (title) ->
