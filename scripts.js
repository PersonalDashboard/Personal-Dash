

$(function(){
	var date = new Date().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
	$('#time').html(date);

	$.getJSON("http://api.openweathermap.org/data/2.5/weather?q=32084&units=metric&appid=42009b873989896f45246d961a6a290c", function(data){
		$('#temp').html(Math.round((data.main.temp * 1.8) + 32) + '&deg;');
	});

	$.getJSON("http://api.openweathermap.org/data/2.5/weather?q=32256&units=metric&appid=42009b873989896f45246d961a6a290c", function(data){
		$('#tempjax').html(Math.round((data.main.temp * 1.8) + 32) + '&deg;');
	});

	$.getJSON("https://api.myjson.com/bins/49kdc", function(data){
		var time_key = Object.keys(data)[0];
		var full_expected = 43;
		var beach_expected = 15;
		var b_expected = 19;
		var southside_expected = 9;

		var full_status = "";
		var beach_status = "";
		var b_status = "";
		var southside_status = "";
		var status_color_codes = {"Clear": "#21A325", "Light": "#D2E620",
			"Moderate":  "#D1B22A", "Heavy": "#EB411E", "Critical": "#171211"};
		if(data[time_key]["full_route"]["time"] > full_expected){

			if(data[time_key]["full_route"]["time"] <= full_expected + 5){
				full_status = "Light";
			}else if(data[time_key]["full_route"]["time"] <= full_expected + 10){
				full_status = "Moderate";
			}else if(data[time_key]["full_route"]["time"] <= full_expected + 15){
				full_status = "Heavy";
			}else{
				full_status = "Critical";
			}

		}else{
			full_status = "Clear";
		}

		if(data[time_key]["beach_route"]["time"] > beach_expected){

			if(data[time_key]["beach_route"]["time"] <= beach_expected + 5){
				beach_status = "Light";
			}else if(data[time_key]["beach_route"]["time"] <= beach_expected + 10){
				beach_status = "Moderate";
			}else if(data[time_key]["beach_route"]["time"] <= beach_expected + 15){
				beach_status = "Heavy";
			}else{
				beach_status = "Critical";
			}
		}else{
			beach_status = "Clear";
		}

		if(data[time_key]["9b_route"]["time"] > b_expected){
			if(data[time_key]["9b_route"]["time"] <= b_expected + 5){
				b_status = "Light";
			}else if(["9b_route"]["time"] <= b_expected + 10){
				b_status = "Moderate";
			}else if(data[time_key]["9b_route"]["time"] <= b_expected + 15){
				b_status = "Heavy";
			}else{
				b_status = "Critical";
			}
		}else{
			b_status = "Clear";
		}

		if(data[time_key]["southside_route"]["time"] > southside_expected){
			if(data[time_key]["southside_route"]["time"] <= southside_expected + 5){
				southside_status = "Light";
			}else if(data[time_key]["southside_route"]["time"] <= southside_expected + 10){
				southside_status = "Moderate";
			}else if(data[time_key]["southside_route"]["time"] <= southside_expected + 15){
				southside_status = "Heavy";
			}else{
				southside_status = "Critical";
			}
		}else{
			southside_status = "Clear";
		}

		$('#travel-time-full').css('background-color', status_color_codes[full_status]);
		$('#travel-time-beach').css('background-color', status_color_codes[beach_status]);
		$('#travel-time-b').css('background-color', status_color_codes[b_status]);
		$('#travel-time-southside').css('background-color', status_color_codes[southside_status]);
	});

	$.getJSON("https://api.myjson.com/bins/2yz52", function(data){
		var online_now = data['online_now'];
		var subscribed = data['subscribed'];

		$('#ruby-online').html(online_now);
		$('#ruby-subscribers').html(subscribed);
	});

	$('.collapse-btn').on('click', function(){
		if($(this).closest('.panel').find('.panel-body').hasClass('collapse')){
			$(this).closest('.panel').find('.panel-body').removeClass('collapse');
			$(this).find('i').removeClass('glyphicon-chevron-up');
			$(this).find('i').addClass('glyphicon-chevron-down');
		}else{
			$(this).closest('.panel').find('.panel-body').addClass('collapse');
			$(this).find('i').removeClass('glyphicon-chevron-down');
			$(this).find('i').addClass('glyphicon-chevron-up');
		}

	});




});
