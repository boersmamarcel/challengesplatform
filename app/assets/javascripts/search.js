var query_path = "/query.json";

$('#instant-search-div').html('<input id="instant-search" type="text" placeholder="Instant search">')

var searchbar = $('#instant-search');

if(searchbar.length > 0) {
  searchbar.focus(function() {
    $('.hide-on-search').toggle(200, function() {
      $('#instant-search-div').animate({width: 300}, 300);
    });
  });

  searchbar.blur(function() {
    $('#instant-search-div').animate({width: 100}, 300, function() {
      $('.hide-on-search').toggle(200);      
    });
  });

  searchbar.typeahead({
    name: 'instant',
    remote: {
      url: query_path + '?q=%QUERY&t=i',
      dataType: "json"
    },
    rateLimitWait: 100,
    template: '<p><strong><a href="{{url}}">{{title}}</a></strong> – {{supervisor}}</p>',
    engine: Hogan,
    limit: 5,
    footer: "<p><a href='/search'>Full search</a></p>",
  });

  searchbar.on('typeahead:selected', function(event, selected) {
    if(selected.url.length > 0)
      window.location = selected.url;
  });
}

if(document.getElementById('page_identifier').value == 'search.index') {
  // Create result list
  enableList();
  var options = { valueNames: [ 'id', 'name' ] };
  var userList = new List('search-list', options);


  $('#search-bar').keyup(function() {
    var query = $('#search-bar').val();

    if(query.length >= 4) {
      var req = $.get(query_path, {q: query, t: "f"}, "json");

      req.done(function(data) {
        userList.clear();

        for(var i = 0; i < data.length; i++) {
          if(data[i].challenge != undefined) {
            $.extend(data[i].challenge, {type: "challenge", onel: "Oneliner..."});
            userList.add(data[i]);
          }
          else {
            console.log("data.challenge not defined, object; " + data[i]);
          }
        }

        if(data.length < 1)
          $('#results_id').html("No results found");
        // show/hide list
      });
    }
  });
}