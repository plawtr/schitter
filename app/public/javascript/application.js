

function showSchitFavouritedNotice(schit) {
	var favourited = !!$(schit).data("favourited");
	var name = $(schit).find(".message").text();
	var message = favourited ? name + " was added to favs" : name + " was removed from favs";   
	var $flash = $("<div></div>").addClass('flash notice').html(message);
	$flash.appendTo('#flash-container');
	window.setTimeout(function() {
		$flash.fadeOut();
	}, 2000);
	console.log(message);
}

function addFavouritesHandler() {
	$('.flag.solid').click(function(event) {
		var schit = $(this).parent();
		var favourited = !!$(schit).data("favourited");
		var NewOpacity = favourited ? 0 : 1;
		$(schit).data("favourited", !favourited);
		$(this).animate({opacity: NewOpacity}, 500);
		showSchitFavouritedNotice(schit);
	});
}

function prepareNewSchitHandler(){
	$('.add-schit').click(function(event) {
		$.get($(this).attr("href"), function(data) {
			console.log(data);
		});
		event.preventDefault();
	});
}

$(function() {
	addFavouritesHandler();
	prepareNewSchitHandler();
})

