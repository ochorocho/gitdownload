$(function() {
	$('#gitOptions object').blur();
	$('#gitIcon').click(function() {
		$("#gitOptions").dialog({
			modal: true,
			width: 500,
			buttons: {
				Download: function() {
					var url = GITDOWNLOAD_CONTROLLER;
					var branch = $('#gitBranch option:selected').val();
					var changeset = $('#revs input:checked').val();
					
					var params = '';
					if(branch !== '') {
						params += 'archive=' + branch;
					} else if(changeset !== undefined) {
						params += 'archive=' + changeset;
					}
					
					if(params == '') {
						$('#revs').before('<div id="flash_notice" class="flash error">' + GITDOWNLOAD_ERROR + '</div>')
					} else {
						$('#flash_notice').remove();
						params += '&repository=' + GITDOWNLOAD_ID;
						params += '&identifier=' + GITDOWNLOAD_REPO;
						params += '&gitFormat=' + $('#gitFormat option:selected').val();
						
						
//						window.open(data.href,'_blank');
						
						$.ajax({
							dataType: "json",
							url: url,
							data: params,
							type: 'GET',
							success: function(data) {
								console.log(data);
								//window.open(data.href,'_blank');
							},
							error: function(data) {
								alert('Error: Please reload!');
							}
						});
					}
				},
				Close: function() {
					$(this).dialog("close");
				}
			}
		});
	});
	$('.gitRadio input').click(function() {
		$('.gitRadio input').not($(this)).removeAttr('checked');
		if ($(this).attr('checked') !== 'checked') {
			$(this).removeAttr('checked');
			$('#flash_notice').remove();
		} else {
			$(this).attr('checked', 'checked');
			$('#flash_notice').remove();
		}
	});
	$('select#gitBranch').on('change', function(e) {
		$('#flash_notice').remove();
		var optionSelected = $("option:selected", this);
		var valueSelected = this.value;
		if (valueSelected !== '') {
			$('#revs').addClass('disabled');
			$('#revs input').removeAttr('checked').attr('disabled', 'disabled');
		} else {
			$('#revs').removeClass('disabled');
			$('#revs input').removeAttr('disabled');
		}
	});
	if ($('#gitBranch option:selected').val() !== '') {
		$('#revs').addClass('disabled');
		$('#revs input').removeAttr('checked').attr('disabled', 'disabled');
	} else {
		$('#revs').removeClass('disabled');
		$('#revs input').removeAttr('disabled');
	}
});