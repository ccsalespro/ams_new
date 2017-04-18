function resizeFieldWidth(){
	var width = $(window).width();

	if (width <= 500){
		$(".form-field-div").removeClass("col-xs-6");
		$(".form-field-div").addClass("col-xs-12");
	} else {
		$(".form-field-div").removeClass("col-xs-12");
		$(".form-field-div").addClass("col-xs-6");
	}
}