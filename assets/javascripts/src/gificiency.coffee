# *************************************
#
#   Gificiency
#   -> Become more GIF-efficient.
#
# *************************************

class @Gificiency

  # -------------------------------------
  #   Initialization
  # -------------------------------------

  # ----- Constructor ----- #

  constructor: (@options) ->
    @init()

  # ----- Init ----- #

  init: ->
    @setDefaultSettings()

    @categories = []
    @parseCategories()

    @setFilterList()

    @search( @getHash() ) if @getHash()

    @events()

  # ----- Set Default Settings ----- #

  setDefaultSettings: ->
    @settings =
      delimiter: '-'
      searchField: $('.search')
      imageClass: 'card'
      items: $('.categories li')
      links: $('.link')
      filter: $('.filter')
      filterToggle: $('.filter-toggle')
      filterLink: $('.filter-link')
      filterList: $('.filter-list')
      filterItem: $('.filter-item')
      filterActiveClass: 'is-expanded'

    $.extend(@settings, @options)

  # -------------------------------------
  #   Events
  # -------------------------------------

  events: ->
    @settings.searchField.on 'keyup', (e) =>
      @search( $(e.currentTarget).val() )

    throttledInjectPopup = _.throttle(@injectPopup, 500)

    @settings.items.on('mouseover', 'a', (e) =>
      elem = $(e.currentTarget)
      image = elem.attr('href')
      throttledInjectPopup(elem, image)
    ).on('mouseout', => @clearImages() )

    @settings.filterToggle.on 'click', (e) =>
      e.preventDefault()
      @settings.filter.toggleClass(@settings.filterActiveClass)

    $('.filter-link').on 'click', (e) =>
      e.preventDefault()
      query = $(e.currentTarget).attr('href')
      window.location.href = "#{query}"
      location.reload()

  #-------------------------------------
  #  Categories
  #-------------------------------------

  # ----- Parse Categories ----- #

  parseCategories: ->
    self = this
    @settings.items.each ->
      elem = $(@)
      category = self.getCategory( elem.text() )

      if category?
        self.categories.push(category)
        elem.addClass("category category--#{category}")

  # ----- List Categories ----- #

  listCategories: ->
    category for category in @categories.unique()

  # ----- Get Category ----- #

  getCategory: (str) ->
    if ~str.indexOf @settings.delimiter
      @trimCategory(str.split(@settings.delimiter)[0].split('.')[0])

  # ----- Trim Category ----- #

  trimCategory: (str) ->
    str.replace(/(\r\n|\n|\r)/gm,"").replace(/\s/g, '')

  # ----- Unique Array ----- #

  Array::unique = ->
    output = {}
    output[@[key]] = @[key] for key in [0...@length]
    value for key, value of output

  # -------------------------------------
  #   Filter
  # -------------------------------------

  setFilterList: ->
    list = @settings.filterList
    $.each @listCategories(), (key, value) =>
      list.append(
        "<li class='filter-item filter-item--#{value}'>
          <a class='filter-link' href='##{value}'>#{value}</a>
         </li>"
      )

  # -------------------------------------
  #   Popup
  # -------------------------------------

  # ----- Inject Popup ----- #

  injectPopup: (elem, image) =>
    elem.parent().append( @popup(image) )

  # ----- Popup ----- #

  popup: (image) ->
    $("<img class='#{@settings.imageClass}' src='#{image}'' />")

  # ----- Clear Images ----- #

  clearImages: ->
    $('img').each -> $(@).remove()

  #-------------------------------------
  #  Search
  #-------------------------------------

  search: (filter) ->
    @settings.links.each ->
      elem = $(@)
      if (elem.text().search( new RegExp(filter, 'i') ) < 0)
        elem.hide()
      else
        elem.show()

  # ----- Get Hash ----- #

  getHash: ->
    if (window.location.hash isnt '')
      window.location.hash.substring(1)
    else
      false
