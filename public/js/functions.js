hljs.tabReplace = '    ';
hljs.initHighlightingOnLoad();

// remap jQuery to $
(function($){})(window.jQuery);
/* trigger when page is ready */
$(document).ready(function (){
	
	$("#bolt").addClass("yellow");
	
	setTimeout(function(){
	    $("#bolt").removeClass("yellow");
	    
	    setTimeout(function(){
		    $("#bolt").addClass("yellow");
		    
		    setTimeout(function(){
			    $("#bolt").removeClass("yellow");
			    
			},100);
		    
		},100);
	    
	},100);

});


/* optional triggers

$(window).load(function() {
	
});

$(window).resize(function() {
	
});

*/