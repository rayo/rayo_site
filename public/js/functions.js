// remap jQuery to $
(function($){})(window.jQuery);


/* trigger when page is ready */
$(document).ready(function (){

	$(window).bind("resize,scroll",function(){
		$("#left").css("top","0");
	})

});


/* optional triggers

$(window).load(function() {
	
});

$(window).resize(function() {
	
});

*/