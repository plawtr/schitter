

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


function fadeOutFlashNotice() {  
	var notice = $('.flash');
	window.setTimeout(function() {
		notice.fadeOut();
	}, 1000);
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

function prepareSchitsHandler(){
	$('.add-schit').click(function(event) {
		var target = $(this)[0];
		console.log(target);
		var spinner = new Spinner(spinnerOpts).spin(target);

		$.get($(this).attr("href"), function(data) {
			if ($('#ajax-form').length == 0) {
				$("#container").prepend("<div id='ajax-form'></div>");
			}
			$("#container #ajax-form").html(data);
			prepareFormHandler();
		});
		event.preventDefault();

		window.setTimeout(function() {
			spinner.stop();
		}, 500);
	});
}

function prepareRemoteFormsHandler(){
	$('.new-user, .new-session').click(function(event) {
		var target = $(this)[0];
		console.log(target);
		var spinner = new Spinner(spinnerOpts).spin(target);

		$.get($(this).attr("href"), function(data) {
			if ($('#ajax-form').length == 0) {
				$("#container").prepend("<div id='ajax-form'></div>");
			}
			$("#container #ajax-form").html(data);
			// prepareFormHandler();
		});
 
		event.preventDefault();
		window.setTimeout(function() {
			spinner.stop();
		}, 500);
		
	});
}

spinnerOpts = {
	  lines: 13, // The number of lines to draw
	  length: 4, // The length of each line
	  width: 2, // The line thickness
	  radius: 5, // The radius of the inner circle
	  corners: 1, // Corner roundness (0..1)
	  rotate: 0, // The rotation offset
	  direction: 1, // 1: clockwise, -1: counterclockwise
	  color: '#000', // #rgb or #rrggbb or array of colors
	  speed: 1, // Rounds per second
	  trail: 60, // Afterglow percentage
	  shadow: false, // Whether to render a shadow
	  hwaccel: false, // Whether to use hardware acceleration
	  className: 'spinner', // The CSS class to assign to the spinner
	  zIndex: 2e9, // The z-index (defaults to 2000000000)
	  top: 'auto', // Top position relative to parent in px
	  left: 'auto' // Left position relative to parent in px
}

function isValidEmail(email) {
	regex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	return regex.test(email);
}

function hasUpper(password) {
	return !!password.match(/[A-Z]/);
}

function hasLower(password) {
	return !!password.match(/[a-z]/g);
}

function hasNumber(password) {
	return !!password.match(/[0-9]/g);
}

// function passwordStrengthMessages(){

// $("input[name='email']").keyup(function(){
// 	console.log(isValidEmail($("input[name='email']").val()))})

// }


$(function(){
	prepareSchitsHandler();
	prepareRemoteFormsHandler();
	addFavouritesHandler();
	fadeOutFlashNotice();
})

