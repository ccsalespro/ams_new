function resizeBoxWidth(){
	var width = $(window).width();

	if (width <= 550){
		$(".interchange-box").removeClass("col-xs-4");
		$(".interchange-box").addClass("col-xs-12 well");
	} else {
		$(".interchange-box").removeClass("col-xs-12 well");
		$(".interchange-box").addClass("col-xs-4");
	}
}