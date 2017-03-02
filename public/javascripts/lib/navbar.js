$(document).ready(function() {
	$('.nav > li').removeClass('active')
	if(window.location.pathname == '/') {
		$('.nav > li > a[href="/"]').parent().addClass('active');
	} else if (window.location.pathname.indexOf('listings') > -1){
		$('.listings-group').addClass('active');
	} else {
		$('.nav > li > a[href*="' + window.location.pathname + '"]').parent().addClass('active');
	}
})