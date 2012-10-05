$( function() {
	$(".form-button").bind('click', function(e) {
		e.preventDefault();
		$.post('/contact/send',
			$("#contact-form").serialize(),
			function(res) {
				$("#jMeow").text(res).animate({ opacity: 1 }, 575);
				setTimeout(function() {
					$("#jMeow").animate({ opacity: 0}, 275);
				}, 7000);
			});
	});
	$(".navigation-button").bind('click', function(e) {
		e.preventDefault();
		movePage( $(".current-page").attr('id'), $(this).attr('id') );
	});
});

function movePage( current_page, direction ) {

	if (direction == 'previous-button') {

		switch (current_page) {
			case 'about':
				new_page = 'projects';
				break;
			case 'contact':
				new_page = 'about';
				break;
			case 'projects':
			default:
				new_page = 'contact';
				break;
		}

	} else {

		switch (current_page) {
			case 'about':
				new_page = 'contact';
				break;
			case 'contact':
				new_page = 'projects';
				break;
			case 'projects':
			default:
				new_page = 'about';
				break;
		}

	}

	$("#" + current_page).removeClass('current-page').hide();
	$("#" + new_page).show().addClass('current-page');

	switch (new_page) {
		case 'about':
			$("#previous-button").html('Projects <i class="icon-cogs"></i>');
			$("#next-button").html('Contact Me <i class="icon-comments"></i>');
		break;
		case 'contact':
			$("#previous-button").html('About Me <i class="icon-info-sign"></i>');
			$("#next-button").html('Projects <i class="icon-cogs"></i>');
		break;
		case 'projects':
		default:
			$("#previous-button").html('Contact Me <i class="icon-comments"></i>');
			$("#next-button").html('About Me <i class="icon-info-sign"></i>');
		break;

	}
}