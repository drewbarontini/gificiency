this.GificiencyAPI = {};

this.GificiencyAPI = (function() {
  var getCategories, getCategory, getCategoryGifs, getGifs, getRandomGif, getRandomGifByCategory, init, randomizer, trimCategory, _categories, _gifs, _initialized;
  _gifs = [];
  _categories = [];
  _initialized = false;
  init = function() {
    getGifs();
    _initialized = true;
    return this;
  };
  trimCategory = function(string) {
    return string.replace(/(\r\n|\n|\r)/gm, "").replace(/\s/g, '');
  };
  randomizer = function(collection) {
    var randomNumber;
    randomNumber = Math.floor(Math.random() * collection.length);
    return collection[randomNumber];
  };
  Array.prototype.unique = function() {
    var key, output, value, _i, _ref, _results;
    output = {};
    for (key = _i = 0, _ref = this.length; 0 <= _ref ? _i < _ref : _i > _ref; key = 0 <= _ref ? ++_i : --_i) {
      output[this[key]] = this[key];
    }
    _results = [];
    for (key in output) {
      value = output[key];
      _results.push(value);
    }
    return _results;
  };
  getCategory = function(string) {
    if (~string.indexOf('-')) {
      string = trimCategory(string.split('-')[0].split('.')[0]);
      return string;
    }
  };
  getCategories = function() {
    return _categories.unique().join(', ');
  };
  getGifs = function() {
    if (!_initialized) {
      $.ajax({
        url: 'http://gificiency.com/gifs.json',
        async: false,
        dataType: 'json',
        success: function(json) {
          return _gifs = json;
        }
      });
    }
    return _gifs;
  };
  getCategoryGifs = function(category) {
    var categoryGifs, gif, _i, _len;
    categoryGifs = [];
    for (_i = 0, _len = _gifs.length; _i < _len; _i++) {
      gif = _gifs[_i];
      if (gif['category'] !== null) {
        _categories.push(gif['category']);
      }
      if (getCategory(gif['name']) === category) {
        categoryGifs.push(gif);
      }
    }
    return categoryGifs;
  };
  getRandomGif = function() {
    var result;
    result = randomizer(_gifs);
    return result['url'];
  };
  getRandomGifByCategory = function(category) {
    var result, set;
    set = getCategoryGifs(category);
    result = randomizer(set);
    return result['url'];
  };
  return {
    init: init,
    all: getGifs,
    categories: getCategories,
    category: getCategoryGifs,
    random: getRandomGif,
    randomByCategory: getRandomGifByCategory
  };
})();
