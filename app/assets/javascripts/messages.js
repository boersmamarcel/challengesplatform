$(document).ready(function() {
  $('#messagetable tr').click(function(event) {
    if(event.target.type !== 'checkbox') {
      $(':checkbox', this).trigger('click');
    }
  });
});

$(document).ready(function() {
  $('#massselector').click(function(event) {
    $(':checkbox').prop('checked', this.checked);
  });
});