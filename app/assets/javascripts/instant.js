var search_div = $('#instant-search-div');
if(search_div.length > 0) {
  // Templating engine; makes stuff look nice :)
  var templater = {
    compile: function(template) {
      var template = '';
      template += '<div class="instant-result">';
      template += '<p class="instant-img pull-left"><img src={{img}} alt="" /></p>';
      template += '<p class="instant-val">{{value}}</p>';
      template += '<p class="instant-sub">{{sub}}</p>';
      template += '</div>';

      return {
        render: function(context) {
          return template
            .replace('{{url}}', context.url)
            .replace('{{value}}', context.value)
            .replace('{{img}}', context.img)
            .replace('{{sub}}', context.sub);
        }
      }
    }
  }

  var query_path = "/query.json";
  search_div.html('<input id="instant-search" type="text" placeholder="Instant search">')

  var searchbar = $('#instant-search');

  searchbar.typeahead({
    name: 'instant',
    remote: {
      url: query_path + '?q=%QUERY&t=i',
      dataType: "json"
    },
    rateLimitWait: 100,
    template: '',
    engine: templater,
    limit: 5,
    footer: "<p><a href='/search'>Full search</a></p>",
  });

  searchbar.on('typeahead:selected', function(event, selected) {
    if(selected.url.length > 0)
      window.location = selected.url;
  });

  // bluf (fancy; clicking a suggestion is no blur)
  var focusin = false;
  $(document).mouseup(function (e) {
    // Do we have focus?
    if (search_div.is(e.target) || search_div.has(e.target).length != 0) {
      // yes; we have focus
      // Are we gaining focus?
      if(!focusin) {
        $('.hide-on-search').toggle(150, function() {
          search_div.animate({width: 320}, 200);
        });
        focusin = true;
      }
    }
    else {
      // no; we have no focus
      //Are we losing focus?
      if(focusin) {
        search_div.animate({width: 100}, 200, function() {
          $('.hide-on-search').toggle(150);      
        });
        focusin = false;
      }
    }
  });
}