function addModal() {
	var el = document.createElement("div");
	el.className = "modal";
	el.id = "messageCenter"
	
	$.ajax("/messages").done(function(data) {
		el.innerHTML = data;
		$(el).modal('show');
	});
	
	$(el).modal('show');
}