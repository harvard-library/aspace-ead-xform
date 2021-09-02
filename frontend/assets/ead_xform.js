/* any js needed for EAD transforms */
$(function () {
    var csvBtnAdded = (typeof  ead_xform_id === 'undefined'); /* if we don't have the id to beginwith, forget it*/    
	/* the defer methodolgy is adapted from https://stackoverflow.com/questions/7486309/how-to-make-script-execution-wait-until-jquery-is-loaded */
	/* since the lower half of the screen loads *after* the javascript is loaded, we need to to this */
    function defer(method) {
		if ($("#download-ead-dropdown").length > 0) {
			method();
		}
		else {
			setTimeout(function() { defer(method) }, 50);
		}
    }

	var addCsvBtn = function () {
		if (!csvBtnAdded) {
			var $eadBtn = $("#download-ead-dropdown");
			if ($eadBtn.length > 0) {
				a = '/resources/' +  ead_xform_id + '/staff_csv';
				$eadBtn.after('<li class="hvd-download-csv"><a href="' + a + '">Download CSV</a></li>');
				csvBtnAdded = true;
			}
		}
	};

    defer(addCsvBtn);

});
