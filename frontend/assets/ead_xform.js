// This is embedded directly in resources/toolbar.html.erb because ArchivesSpace core,
// after visiting a resource page via link (but not on refresh), loads that component
// twice, overwriting out any additions to the menu

let $eadBtn = $("#download-ead-dropdown")

if ($("#hvd-download-csv").length === 0) {
	if ($eadBtn) {
		a = '/resources/' +  ead_xform_id + '/staff_csv';
		$eadBtn.after('<li class="hvd-download-csv" id="hvd-download-csv"><a href="' + a + '">Download CSV</a></li>');
	}
}
