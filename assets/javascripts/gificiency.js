var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.Gificiency = (function() {
  function Gificiency(options) {
    this.options = options;
    this.injectPopup = __bind(this.injectPopup, this);
    this.init();
  }

  Gificiency.prototype.init = function() {
    this.setDefaultSettings();
    this.categories = [];
    this.parseCategories();
    this.setFilterList();
    if (this.getHash()) {
      this.search(this.getHash());
    }
    return this.events();
  };

  Gificiency.prototype.setDefaultSettings = function() {
    this.settings = {
      delimiter: '-',
      searchField: $('.search'),
      imageClass: 'card',
      items: $('.categories li'),
      links: $('.link'),
      filter: $('.filter'),
      filterToggle: $('.filter-toggle'),
      filterLink: $('.filter-link'),
      filterList: $('.filter-list'),
      filterItem: $('.filter-item'),
      filterActiveClass: 'is-expanded'
    };
    return $.extend(this.settings, this.options);
  };

  Gificiency.prototype.events = function() {
    var throttledInjectPopup;
    this.settings.searchField.on('keyup', (function(_this) {
      return function(e) {
        return _this.search($(e.currentTarget).val());
      };
    })(this));
    throttledInjectPopup = _.throttle(this.injectPopup, 500);
    this.settings.items.on('mouseover', 'a', (function(_this) {
      return function(e) {
        var elem, image;
        elem = $(e.currentTarget);
        image = elem.attr('href');
        return throttledInjectPopup(elem, image);
      };
    })(this)).on('mouseout', (function(_this) {
      return function() {
        return _this.clearImages();
      };
    })(this));
    this.settings.filterToggle.on('click', (function(_this) {
      return function(e) {
        e.preventDefault();
        return _this.settings.filter.toggleClass(_this.settings.filterActiveClass);
      };
    })(this));
    return $('.filter-link').on('click', (function(_this) {
      return function(e) {
        var query;
        e.preventDefault();
        query = $(e.currentTarget).attr('href');
        window.location.href = "" + query;
        return location.reload();
      };
    })(this));
  };

  Gificiency.prototype.parseCategories = function() {
    var self;
    self = this;
    return this.settings.items.each(function() {
      var category, elem;
      elem = $(this);
      category = self.getCategory(elem.text());
      if (category != null) {
        self.categories.push(category);
        return elem.addClass("category category--" + category);
      }
    });
  };

  Gificiency.prototype.listCategories = function() {
    var category, _i, _len, _ref, _results;
    _ref = this.categories.unique();
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      category = _ref[_i];
      _results.push(category);
    }
    return _results;
  };

  Gificiency.prototype.getCategory = function(str) {
    if (~str.indexOf(this.settings.delimiter)) {
      return this.trimCategory(str.split(this.settings.delimiter)[0].split('.')[0]);
    }
  };

  Gificiency.prototype.trimCategory = function(str) {
    return str.replace(/(\r\n|\n|\r)/gm, "").replace(/\s/g, '');
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

  Gificiency.prototype.setFilterList = function() {
    var list;
    list = this.settings.filterList;
    return $.each(this.listCategories(), (function(_this) {
      return function(key, value) {
        return list.append("<li class='filter-item filter-item--" + value + "'> <a class='filter-link' href='#" + value + "'>" + value + "</a> </li>");
      };
    })(this));
  };

  Gificiency.prototype.injectPopup = function(elem, image) {
    return elem.parent().append(this.popup(image));
  };

  Gificiency.prototype.popup = function(image) {
    return $("<img class='" + this.settings.imageClass + "' src='" + image + "'' />");
  };

  Gificiency.prototype.clearImages = function() {
    return $('img').each(function() {
      return $(this).remove();
    });
  };

  Gificiency.prototype.search = function(filter) {
    return this.settings.links.each(function() {
      var elem;
      elem = $(this);
      if (elem.text().search(new RegExp(filter, 'i')) < 0) {
        return elem.hide();
      } else {
        return elem.show();
      }
    });
  };

  Gificiency.prototype.getHash = function() {
    if (window.location.hash !== '') {
      return window.location.hash.substring(1);
    } else {
      return false;
    }
  };

  return Gificiency;

})();
