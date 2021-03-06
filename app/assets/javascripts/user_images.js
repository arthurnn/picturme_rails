$(function(){
	Context.prototype = {
		user_images: { 
			init: function() {
				
				$(".share-tw").click(function() {
					var $t = $(this), url = $t.attr("href"), title = $t.attr("title");
					url += "?text=" + escape("I just uploaded a picture to #picturme " + $("#detail-url").val());
					popup(url, title)
					return false;
				});
				$(".share-fb").click(function() {
					var $t = $(this), url = "http://www.facebook.com/sharer.php", title = $t.attr("title"), href = location.href.indexOf("localhost") != -1 ? "http://www.pictur.me" : $("#detail-url").val();
					url += "?u=" + href;
					url += "&t=" + escape("I just uploaded an image on picture.me");

					console.log(url);

					popup(url, title)
					return false;
				});
				$(".close").click(function() {
					$(this).parent().hide();
				});
				var id = $("#picture").data('picture-id');
				//$("#thumbs_list").load('/detail/thumbs/' + id, __context.user_images.makePag);
				
				this.zoomTiles();
			}, 
			makePag : function() {
				var id = $("#picture").data('picture-id');
				$('.pagination a').bind('click', function() {
					$("#thumbs_list").load('/detail/thumbs/' + id + '?page=' + $(this).data('page'), __context.display.makePag);
				})
			},
			zoomTiles: function(){

				var $pic = $("#picture"),
					url_large = $pic.data('picture-large'),
					w=$pic.data('picture-large-h'),
					h=$pic.data('picture-large-h');

				 $("<img />")
		        .attr("alt", "")
		        .attr("id", "image")
		        .attr("src", url_large)
		        .css({
		            height: h,
		            width: w
		        })
		        .appendTo("#picture .large");
		        $("#image").load(function() {
		        	//$(this).addClass("hide");
		        	$("<canvas />").attr("id", "tutorial").css({
		        		postition: "relative",
		        		display: "block",
		        		margin: "-50px 0 0 -50px"
		        	}).appendTo("#picture");
		            var canvas = document.getElementById("tutorial");
		            if (canvas.getContext) {
		                var $image = $("#picture .large img"),
		                    $thumb = $("#picture .small img"),
		                    image = $image[0],
		                    thumb = $thumb[0],
		                    width = $thumb.width(),
		                    height = $thumb.height(),
		                    ctx = canvas.getContext("2d"),
		                    magnifierSize = 100,
		                    widthRatio = Math.round($image.width() / $thumb.width()),
		                    heightRatio = Math.round($image.height() / $thumb.height());

		                $thumb.addClass("hide");

		                width = width > 0 ? width : 600;
		                height = height > 0 ? height : 600;

		                canvas.setAttribute("width", width + magnifierSize);
		                canvas.setAttribute("height", height + magnifierSize);

		                ctx.drawImage(thumb, magnifierSize/2, magnifierSize/2);
		                var position = $(canvas).position();
		                $("#tutorial").mousemove(function(evt) {
		                    var x = parseInt((evt.pageX-position.left+50) - magnifierSize/2),
		                        y = parseInt((evt.pageY-position.top+50) - magnifierSize / 2);
		                    ctx.clearRect(0, 0, width + magnifierSize, height + magnifierSize);
		                    ctx.drawImage(thumb, magnifierSize/2, magnifierSize/2);
		                    try {
		                        ctx.drawImage(image, x*widthRatio, y*heightRatio, magnifierSize, magnifierSize, x, y, magnifierSize, magnifierSize);
		                    } catch (e) {
		                    }
		                });
		            } else {
		                  //browser doesn't support canvas
		                  $(".zoom").anythingZoomer({
		                    switchEvent: false
		                  });
		                  // unhide the image
		                  $image.removeClass("hide");
		            }
		        }); 
			}

		}
	}

})
