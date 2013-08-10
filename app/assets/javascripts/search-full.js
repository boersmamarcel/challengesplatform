// Are we on the right page?
if($('#page_identifier').length > 0 && $('#page_identifier').val() === 'search.index') {
  var input = $('#search-full-query'),
      resultsList = $('#search-full-resultlist');

  var template = [
    '<li class="search-full-result search-full-type-{{type}}">',
    '  <a class="value" href="{{url}}">{{value}}</a>',
    '  <p class="sub">{{sub}}</p>',
    '</li>'
  ].join('');

  var renderer = templateEngine.compile(template);

  // Switches between noresults/loading/results/nothing (below search bar)
  var show = function(toShow) {
    $('.search-full-hideable').hide();

    switch(toShow) {
      case 'results':   $('#search-full-results').show(); break;
      case 'loading':   $('#search-full-loading').show(); break;
      case 'noresults': $('#search-full-noresults').show(); break;
    }
  };

  // Filters results
  var currentFilter = 'all';
  var filter = function(visible) {
    $('.search-full-result').hide();

    currentFilter = visible;
    switch(visible) {
      case 'users': $('.search-full-type-U').show(); break;
      case 'challenges': $('.search-full-type-C').show(); break;
      case 'messages': $('.search-full-type-M').show(); break;
      case 'pages': $('.search-full-type-P').show(); break;
      case 'all': $('.search-full-result').show(); break;
    }
    checkFiltered();
  };

  var checkFiltered = function() {
    var hasVisibleItems = false;
    $('.search-full-result').each(function() {
      if($(this).is(':visible')) {
        hasVisibleItems = true;
        return false;
      }
    });
    $('#search-full-filter-noresults').toggle(! hasVisibleItems);
  };

  var updateResults = function(data) {
    if(data.length == 0) {
      show('noresults');
      return;
    }

    var html = '';
    for(var i = 0; i < data.length; i++)
      html += renderer.render(data[i]);

    resultsList.html(html);
    filter(currentFilter);
    show('results');
    checkFiltered();
  };

  var getResults = function() {
    var query = input.val();

    if(query.length < 2) {
      show(); // Don't show anything (not even "no results")
      return;
    }

    show('loading');

    $.get('/query.json', {q: query, t: 'f'}, 'json')
      .done(function(data) {
        updateResults(data);
      })
      .fail(function(jqXHR, textStatus, errorThrown) {
        console.log('failed request; ' + textStatus);
      });
  };

  $('#search-full-results .filter-btn').each(function() {
    // For each select
    $(this).click(function() {
      $('.filter-btn').removeClass('filter-selected');
      $(this).addClass('filter-selected');
      filter($(this).attr('filterType'));
    });
  });

  (function() {
    var url = window.location.toString(),
        q = (url.indexOf('q=') > -1) ? url.substring(url.indexOf('q=') + 2) : '';
    input.val(q);
    getResults();

    input.keyup(getResults);
  })();
}