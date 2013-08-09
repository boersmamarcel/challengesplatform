// Enables List.js for usermanagement
if($('#page_identifier').length > 0 && $('#page_identifier').val() === 'admin/usermanagement.index') {
    var options = {
        valueNames: [ 'id', 'firstname', 'lastname', 'email', 'role', 'state', 'last_login' ]
    };

    var userList = new List('user-list', options);

    userList.sort('id', {'asc': true});
}