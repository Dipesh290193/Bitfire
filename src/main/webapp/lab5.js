$(function(){
$('input[name=name]').keyup(function() {	
	var x = $(this).attr('data-model');
	$("[data-model = " + x + "]").html($(this).val());
	
});
});


$(function(){
$('input[name=salary]').keyup(function() {	
	var x = $(this).attr('data-model');
	$("[data-model = " + x + "]").html($(this).val());
});
});
