# *************************************
#
#   Gificiency API
#   -> Parse and display from JSON file
#
# *************************************

# -------------------------------------
#   Namespace
# -------------------------------------

@GificiencyAPI = {}

# -------------------------------------
#   Module
# -------------------------------------

@GificiencyAPI = do ->

  # -------------------------------------
  #   Private Variables
  # -------------------------------------

  _gifs        = []
  _categories  = []
  _initialized = false

  # -------------------------------------
  #   Initialize
  # -------------------------------------

  init = ->
    getGifs()
    _initialized = true
    return @

  # -------------------------------------
  #   Trim Category
  # -------------------------------------

  trimCategory = (string) ->
    string.replace(/(\r\n|\n|\r)/gm,"").replace(/\s/g, '')

  # -------------------------------------
  #   Randomizer
  # -------------------------------------

  randomizer = (collection) ->
    randomNumber = Math.floor( Math.random() * collection.length )
    return collection[randomNumber]

  # -------------------------------------
  #   Unique Array
  # -------------------------------------

  Array::unique = ->
    output = {}
    output[ @[key] ] = @[key] for key in [0...@length]
    value for key, value of output

  # -------------------------------------
  #   Get Category
  # -------------------------------------

  getCategory = (string) ->
    if ~string.indexOf '-'
      string = trimCategory( string.split('-')[0].split('.')[0] )
      return string

  # -------------------------------------
  #   Get Categories
  # -------------------------------------

  getCategories = ->
    return _categories.unique().join(', ')

  # -------------------------------------
  #   Get GIFs
  # -------------------------------------

  getGifs = ->
    unless _initialized
      $.ajax
        url: 'http://gificiency.com/gifs.json',
        async: false,
        dataType: 'json',
        success: (json) ->
          _gifs = json

    return _gifs

  # -------------------------------------
  #   Get Category GIFs
  # -------------------------------------

  getCategoryGifs = (category) ->
    categoryGifs = []

    for gif in _gifs

      unless gif['category'] == null
        _categories.push gif['category']

      if getCategory( gif['name'] ) == category
        categoryGifs.push gif

    return categoryGifs

  # -------------------------------------
  #   Get Random GIF
  # -------------------------------------

  getRandomGif = ->
    result = randomizer(_gifs)
    return result['url']

  # -------------------------------------
  #   Get Random GIF by Category
  # -------------------------------------

  getRandomGifByCategory = (category) ->
    set = getCategoryGifs(category)
    result = randomizer(set)
    return result['url']

  # -------------------------------------
  #   Public Methods
  # -------------------------------------

  init: init
  all: getGifs
  categories: getCategories
  category: getCategoryGifs
  random: getRandomGif
  randomByCategory: getRandomGifByCategory

# -------------------------------------
#   Usage
# -------------------------------------
#
# GificiencyAPI.init().all()                   => returns all GIFs
# GificiencyAPI.init().categories()            => returns a list of available categories
# GificiencyAPI.init().category('sad')         => returns a set of GIFs for specified category
# GificiencyAPI.init().random()                => returns a single, random GIF
# GificiencyAPI.init().randomByCategory('sad') => returns a single, random GIF based on category
#

