/**
 * lastPath.js
 */

(function($) {
	$.fn.greenify = function(options) {

		var settings = $.extend({
			color : "#556b2f",
			backgroundColor : "white"
		}, options);

		return this.css({
			color : settings.color,
			backgroundColor : settings.backgroundColor
		});

	};
}(jQuery));

// 실행!
$(document).ready(function() {
	// $("div").greenify({
	// color : "orange"
	// });
	
	$.fn.select2.defaults.set("theme", "bootstrap");
	$("#statnFnm").select2({
		data: subwayList,
		placeholder: "지하철 선택"
	})
	.on('select2:select', function (e) {
		var data = e.params.data;
		$.ajax({
			url: "api/path/searchLastTrainTimeByIDService/" + data.id,
			type: "GET",
			dataType: "JSON"
		})
		.done(function(res) {
			//console.log(res);
			buildLastSubway(res);
		})
		.fail(function(err) {
			console.log(err);
		});
	});
	
	$("#busRouteNm").select2({
		ajax: {
			url: "api/path/getBusRouteList",
			dataType: "json",
			minimumInputLength: 2,
			processResults: function(data) {
				return {
					results: data
				};
			}
		},
		placeholder: "버스 번호 입력"
	}).on('select2:select', function (e) {
		var data = e.params.data;
		$.ajax({
			url: "api/path/getStaionByRoute/" + data.id,
			type: "GET",
			dataType: "JSON"
		})
		.done(function(res) {
			// console.log(res);
			buildBusRoute(res);
		})
		.fail(function(err) {
			console.log(err);
		});
	});
});

var buildLastSubway = function(res) {
	var $wrap = $('#searchLastTrainTimeByID');
	$wrap.removeClass('mb-0').addClass('mb-3').html('');
	$.each(res, function(i, arr) {
		$('<li>', {'class': 'list-group-item list-group-item-action list-group-item-secondary font-weight-bold'})
		.text(i == 0 ? '상행/내선' : '하행/외선')
		.appendTo($wrap);
		$.each(arr, function(i2, item) {
			$('<li>', {'class': 'list-group-item list-group-item-action'})
			.append(
				$('<div>', {class: 'subName'}).append(
					$('<span>', {class: 'text-primary mr-2'}).text('종점'),
					$('<span>').text(item.SUBWAYENAME)				
				),
				$('<div>', {class: 'time'}).append(
					$('<span>', {class: 'text-primary mr-2'}).text('출발시간'),
					$('<span>').text(item.LEFTTIME)				
				)
			)
			.appendTo($wrap);
		});
	});
};

var buildBusRoute = function(res) {
	var $wrap = $('#getStaionByRoute');
	$wrap.removeClass('mb-0').addClass('mb-3').html(''); // 내용 초기화
	$.each(res, function(i, item) {
		$('<li>', {'class': 'list-group-item list-group-item-action'})
		.append(
			$('<span>').text(item.stationNm),
			item.lastTm == ':' ? "" : $('<time>', {class: 'text-primary ml-2'}).text(item.lastTm)
		)
		.appendTo($wrap);
	});
};
