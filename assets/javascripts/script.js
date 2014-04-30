$(document).ready(function() { });

$(function() {
    $('#gitUrl').blur();

	$('#gitIcon').click(function() {
		$("#gitOptions").dialog({
			modal: true,
			buttons: {
				Download: function() {
					$(this).dialog("close");
				}
			}
		});
	});
});