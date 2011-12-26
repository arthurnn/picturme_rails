$(function(){
	Context.prototype = {
		pixel: {
			init: function(){
				$("form").bind("reset", function(){ });				
			
				$("#uploadform").submit(function() {
					if(!$("input[type=file]").val()) {
						$(".error").fadeIn();
						return false;
					}
					var $form = $(this);
					$form.submit(function() {
						return false
					});
					$("#upload_container").hide();
					$("#load_container").show();

					this.submit();

					return true;

				});
			
			
				$("#loader").ready(function() {
					var $t = $("#loader");

					setInterval(function() {
						if($t.text().length >= 3) {
							$t.text(".");
						} else {
							$t.append(".");
						}
					}, 1000);
				});
			
	
				if($("#videoSplash").length){
					//video config
					var videoSplash = new MediaElement('videoSplash', {
						//mode: 'none',
						loop : false,
						defaultVideoWidth : 940,
						defaultVideoHeight : 528,
						pluginWidth : -1,
						pluginHeight : -1,
						success : function(mediaElement, dom) {
							$("#upload_container").hide();
							$(".hero-unit").css('padding', '0px');

							// add event listener
							mediaElement.addEventListener('ended', function(e) {
								__context.home.fadeOutVideo(mediaElement);
							}, false);

							mediaElement.play();

						}
					});
					$("#splashContainer").bind('click', function(){
						__context.home.fadeOutVideo(videoSplash);
					});
				}

			
			},
			fadeOutVideo : function(mediaElement){
				$("#splashContainer").fadeOut(function(){
					$(".hero-unit").css('padding','60px');
					$("#upload_container").show();
					mediaElement.stop();
				});
			}
		}
	}

})