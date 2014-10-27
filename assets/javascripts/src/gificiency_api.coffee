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

  _gifs = []

  # -------------------------------------
  #   Initialize
  # -------------------------------------

  init = ->
    getGifs()
    @

  # -------------------------------------
  #   Get Category
  # -------------------------------------

  getCategory = (string) ->
    if ~string.indexOf '-'
      string = trimCategory( string.split('-')[0].split('.')[0] )
      return string

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
  #   Get GIFs
  # -------------------------------------

  getGifs = ->
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
  categories: getCategoryGifs
  random: getRandomGif
  category: getRandomGifByCategory

# -------------------------------------
#   Usage
# -------------------------------------
#
# GificiencyAPI.init().all()             => returns all GIFs
# GificiencyAPI.init().categories('sad') => returns a set of GIFs based on category
# GificiencyAPI.init().random()          => returns a single, random GIF
# GificiencyAPI.init().category('sad')   => returns a single, random GIF based on category
#

