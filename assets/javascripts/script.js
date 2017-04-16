$(function() {
    $("#git-options").dialog({
        autoOpen: false,
        modal: true,
        width: 500,
        height: 340,
        buttons: {
            Download: function() {
                var url = GITDOWNLOAD_CONTROLLER;
                var branch = $('#gitBranch option:selected').val();
                var changeset = $('#revs input:checked').val();
                var params = '';
                if (branch !== '') {
                    params += 'archive=' + branch;
                } else if (changeset !== undefined) {
                    params += 'archive=' + changeset;
                }
                if (params === '') {
                    $('#revs').before('<div id="flash_notice" class="flash error">' + GITDOWNLOAD_ERROR + '</div>');
                } else {
                    $('#flash_notice').remove();
                    params += '&repository=' + GITDOWNLOAD_ID;
                    params += '&identifier=' + GITDOWNLOAD_REPO;
                    params += '&type=' + $('#gitType').val();
                    params += '&gitFormat=' + $('#git-format option:selected').val();
                    var spinner = '<div id="generate-spinner">';
                    spinner += '<div class="spinner"><div class="rect1"></div><div class="rect2"></div><div class="rect3"></div><div class="rect4"></div><div class="rect5"></div></div>';
                    spinner += '<div class="spinText">Archiving in progress ...</div></div>';
                    $('body').prepend(spinner);
                    $(document).keyup(function(e) {
                        if (e.keyCode == 27) {
                            $('#generate-spinner').remove();
                        }
                    });
                    
                    $.ajax({
                        dataType: "json",
                        url: url,
                        data: params,
                        type: 'POST',
                        success: function(data) {
                            $('#generate-spinner').remove();
                            $('#frame').html('<iframe src="' + url + '?filename=' + data.filename + '"></iframe>');
                        },
                        error: function() {
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
    $('#git-options object').blur();
    $('#git-icon').click(function() {
        $("#git-options").dialog("open");
    });
    $('.gitRadio input').click(function() {
        $('.gitRadio input').not($(this)).removeAttr('checked');
        if ($(this).attr('checked') == 'checked') {
            $(this).removeAttr('checked');
            $('#flash_notice').remove();
        } else {
            $(this).attr('checked', 'checked');
            $('#flash_notice').remove();
        }
    });
    $('select#gitBranch').on('change', function() {
        $('#flash_notice').remove();
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