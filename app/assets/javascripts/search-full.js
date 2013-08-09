// Are we on the right page?
if($('#page_identifier').length > 0 && $('#page_identifier').val() === 'search.index') {
  //Scope is in a single function; everything private
  (function() {
    var input = $('#search-full-query');
    var results = $('#search-full-results');

    var template = [
      '<div>',
      '  <a href="{{url}}">{{value}}</a>',
      '  <p>{{sub}}</p>',
      '</div>'
    ].join('');

    var renderer = templateEngine.compile(template);

    var updateResults = function(data) {
      var html = '';
      for(var i = 0; i < data.length; i++) {
        html += renderer.render(data[i]);
      }
      results.html(html);
    };

    var getResults = function() {
      var query = input.val();
      $.get('/query.json', {q: query, t: 'f'}, 'json')
        .done(function(data) {
          updateResults(data);
        })
        .fail(function(jqXHR, textStatus, errorThrown) {
          console.log('failed request; ' + textStatus);
        });
    };

    (function() {
      var url = window.location.toString(),
          q = (url.indexOf('q=') > -1) ? url.substring(url.indexOf('q=') + 2) : '';
      input.val(q);
      getResults();

      input.keyup(getResults);

    })();
  })();
}