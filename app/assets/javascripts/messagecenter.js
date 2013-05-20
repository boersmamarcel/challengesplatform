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