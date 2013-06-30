if(document.getElementById('page_identifier').value == 'search.index') {
  enableList();

  var options = {
      valueNames: [ 'category', 'name' ]
  };

  $.getJSON(data_resource, function(data ) {
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

  });
}