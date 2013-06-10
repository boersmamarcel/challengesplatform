var idtags = new Array();
var texttags = new Array();

function buildRecipientList() {
	return texttags.map(function(value, index) {
		return "<a href = 'javascript:removeTag(" + index + ")'>&times;</a> " + value;
	}).join(", ");
}

function removeTag(id) {
	idtags.splice(id, 1);
	texttags.splice(id, 1);
	refreshTags();
}

function refreshTags() {
	document.getElementById("groupid").value = idtags.join(",");
	document.getElementById("peopletags").innerHTML = buildRecipientList();
}

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

function composeMessage(receiver_type, receiver_id, options) {
	options = options || {};
	if(options.show_user_field === undefined) {
		options.show_user_field = false;
	}
	options.subject = options.subject || "";
	options.contents = options.contents || "";
	
	function split(val) {
		return val.split(/,\s*/);
	}
	
	function extractLast(term) {
		return split(term).pop();
	}
	
	var el = document.createElement("div");
	el.className = "modal";
	el.id = "composeMessage"
	
	$.ajax("/messages/compose").done(function(data) {
		
		idtags = new Array();
		texttags = new Array();
		
		el.innerHTML = data;
		document.getElementById("grouptype").value = receiver_type;
		document.getElementById("groupid").value = receiver_id;
		document.getElementById("subject").value = options.subject;
		document.getElementById("body").value = options.contents;
		
		if(options.show_user_field) {
			newElement = document.createElement("div");
			newInput = document.createElement("input");
			newInput.type = "text";
			newInput.id = "to-field";
			$(newInput).attr("placeholder", "Add a recipient");
			newInput.className = "span5";
			newElement.appendChild(newInput);
		
			peopleTags = document.createElement("label");
			peopleTags.id = "peopletags";
		
			document.getElementById("subject").parentNode.insertBefore(newElement, document.getElementById("subject"));
			document.getElementById("subject").parentNode.insertBefore(peopleTags, newElement);
		
			$(newInput).autocomplete({
				minLength: 0,
				source: "/messages/autosuggest",
				focus: function() {
					return false;
				},
				select: function(event, ui) {
					idtags.push(ui.item.value);
					texttags.push(ui.item.label);
					refreshTags();
				
					this.value = "";
					return false;
				}
			});
		}
		
		
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