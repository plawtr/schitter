

function showSchitFavouritedNotice(schit) {
	var favourited = !!$(schit).data("favourited");
	var name = $(schit).find(".message").text();
	var message = favourited ? name + " was added to favourites" : name + " was removed from favourites";   
	var $flash = $("<div></div>").addClass('flash notice').html(message);
	$flash.appendTo('#flash-container');
	window.setTimeout(function() {
		$flash.fadeOut();
	}, 1000);
	// console.log(message);
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

function prepareFormHandler(){
	var form = $('#container #ajax-form form');
	form.submit(function(event) {
		var addSchit = function(data) {
			$('#schits').prepend(data);
			$('#ajax-form').remove();
		}
		var data = form.serialize();
		$.post(form.attr('action'), data, addSchit);
		event.preventDefault();
	});
}

function prepareRemoteFormsHandler(){
	$('.add-schit, .new-user, .new-session').click(function(event) {
		$.get($(this).attr("href"), function(data) {
			if ($('#ajax-form').length == 0) {
				$("#container").prepend("<div id='ajax-form'></div>");
			}
			$("#container").html(data);
			prepareFormHandler();
		});
		event.preventDefault();
	});
}

$(function() {
	addFavouritesHandler();
	prepareRemoteFormsHandler();
})

