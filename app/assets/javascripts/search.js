var query_path = "/query.json";

if($('#instant-search').length > 0) {
  $('#instant-search').typeahead({
    name: 'instant',
    valueKey: 'title',
    remote: {
      url: query_path + '?q=%QUERY&t=i',
      dataType: "json",
      filter: function(parsedResponse) {
        console.log(parsedResponse);
        return parsedResponse;
      }
    },
    rateLimitWait: 100,
    template: '<p><strong><a href="{{url}}">{{value}}</a></strong> – {{id}}</p>',
    engine: Hogan,
    limit: 5,
    footer: "<p><a href='/search'>Full search</a></p>",
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