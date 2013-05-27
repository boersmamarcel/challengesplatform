function addModal() {
	var el = document.createElement("div");
	el.className = "modal";
	el.id = "messageCenter"
	
	$.ajax("/messages").done(function(data) {
		el.innerHTML = data;
		$(el).modal('show');
		$(el).on('hidden', function() {
			el.parentNode.removeChild(el);
		});
	});
	
	$(el).modal('show');
}

function composeMessage(receiver_type, receiver_id) {
	var el = document.createElement("div");
	el.className = "modal";
	el.id = "composeMessage"
	
	$.ajax("/messages/compose").done(function(data) {
		el.innerHTML = data;
		document.getElementById("grouptype").value = receiver_type;
		document.getElementById("groupid").value = receiver_id;
		$(el).modal('show');
		$(el).on('hidden', function() {
			el.parentNode.removeChild(el);
		});
	});
	
	$(el).modal('show');
}

$(function() {
	$("#nosend_tooltip").tooltip()
});