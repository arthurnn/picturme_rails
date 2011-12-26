// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
/*
Author: @oliviernt , @arthurnn89
*/
var Context = (function($){
	
	var popup = function(url, title) {
	    return window.open(url, title, "height=300,width=550");
	};
	
	var Context = function(controller, action){
		__context = this;
		
		if (controller !== "" && this[controller]) {
			//console.log(this[controller].init);
			this[controller].init();
			
			if (typeof this[controller][action] == "function"){
				this[controller][action]();
			}
			
		}
		
	}
	
	$(document).ready(function () {
		var body = document.body,
			controller = body.getAttribute("data-controller"),
			action = body.getAttribute("data-action");
			
			console.log("controller: "+controller)
		
	    new Context(controller, action);
	})
	
	return Context;
	
})(jQuery);
