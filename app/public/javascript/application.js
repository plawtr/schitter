

function showSchitFavouritedNotice(schit) {
	var favourited = !!$(schit).data("favourited");
	var name = $(schit).find(".message").text();
	var message = favourited ? name + " was added to favs" : name + " was removed from favs";   

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


$(function() {
	addFavouritesHandler();

})

