var Gificiency = (function() {
  'use strict';

  var searchField = $('.search'),
      items = $('li'),
      links = $('a');

  var search = function(filter) {
    links.each(function() {
      var elem = $(this);
      if (elem.text().search( new RegExp(filter, 'i') ) < 0) {
        elem.hide();
      } else {
        elem.show();
      }
    });
  };

  var getHash = function() {
    var filter;
    if (window.location.hash != '') {
      filter = window.location.hash.substring(1);
    } else {
      filter = false;
    }
    return filter;
  };

  var clearImages = function() {
    $('img').each(function() {
      $(this).remove();
    });
  };

  var popup = function(image) {
    return $('<img src="'+ image +'" />');
  };

  var init = function() {
    if ( getHash() ) {
      search( getHash() );
    }
    events();
  };

  var events = function() {
    searchField.on('keyup', function() {
      search( $(this).val() );
    });

    items.on('mouseover', function() {
      var elem = $(this).find('a'), image = elem.attr('href');
      elem.parent().append( popup(image) );
    }).on('mouseout', function() {
      clearImages();
    });
  };

  var Gificiency = {
    init: init,
    events: events
  };

  return Gificiency;
})();
