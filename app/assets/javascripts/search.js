if(document.getElementById('page_identifier').value == 'search.index') {
  enableList();

  var options = {
      valueNames: [ 'id', 'name' ]
  };

  var userList = new List('search-list', options);

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
        for(var i = 0; i < data.length; i++) {
          if(data[i].challenge != undefined) {
            $.extend(data[i].challenge, {type: "challenge", onel: "Oneliner..."});
            userList.add(data[i].challenge);
          }
          else {
            console.log("data.challenge not defined, object; " + data[i]);
          }
        }

        if(data.length < 1)
          $('#results_id').html("No results found");
      })
    }
  })
}