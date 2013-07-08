class @Gificiency
  constructor: (@options) ->
    @init(@options)

  init: (@options) ->
    @search( @getHash() ) if @getHash()
    @events()

  events: ->
    @options.searchField.on 'keyup', (e) =>
      @search( $(e.currentTarget).val() )

    throttledInjectPopup = _.throttle(@injectPopup, 500)

    @options.items.on('mouseover', (e) =>
      elem = $(e.currentTarget).find('a')
      image = elem.attr('href')
      throttledInjectPopup(elem, image)
    ).on('mouseout', => @clearImages() )

  injectPopup: (elem, image) => elem.parent().append( @popup(image) )

  search: (filter) ->
    @options.links.each ->
      elem = $(@)
      if (elem.text().search( new RegExp(filter, 'i') ) < 0)
        elem.hide()
      else
        elem.show()

  getHash: ->
    if (window.location.hash != '')
      filter = window.location.hash.substring(1)
    else
      filter = false
    filter

  clearImages: ->
    $('img').each -> $(@).remove()

  popup: (image) ->
    $("<img class='gif' src='#{image}'' />")
