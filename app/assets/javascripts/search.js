if(document.getElementById('page_identifier').value == 'search.index') {
  enableList();

  var options = {
      valueNames: [ 'category', 'name' ]
  };

  /*$.getJSON(data_resource, function(data ) {
    var userList = new List('search-list', options, data);

    $('#filter-users').click(function() {
        userList.filter(function(item) {
          return item.values().category == "user";
        });
        return false;
    });
    $('#filter-none').click(function() {
        userList.filter();
        return false;
    });
  });*/

  $('#search-bar').keypress(function() {
    var query = $('#search-bar').val();

    if(query.length >= 4) {
      var req = $.post(query_path, {q: query}, "json");

      req.done(function(data) {
        var results = "";

        if(data.length >= 1) {
          results = data[0].challenge.title + " (" + data[0].challenge.id + ")";
          for(var i = 1; i < data.length; i++) {
            results += ", " + data[i].challenge.title + " (" + data[i].challenge.id + ")";;
          }
        }
        else {
          results = "No results found";
        }

        $('#results_id').html(results);
      })
    }
  })
}