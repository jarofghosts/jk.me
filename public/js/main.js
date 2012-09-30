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
});