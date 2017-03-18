$(function(){
	var today = new Date();

	$('#check-in-date').datepicker({
		format: 'D, dd M yyyy',
		startDate: 'new Date',
		autoclose: true,
	}).datepicker('setDate', today).datepicker('update');

	var inThreeDays = new Date(today.getTime() + (3 * 86400000));

	$('#check-out-date').datepicker({
		format: 'D, dd M yyyy',
		autoclose: true,
		defaultViewDate: {year: 2017, month: 03, day: 21}
	}).datepicker('setDate', inThreeDays).datepicker('update');
})