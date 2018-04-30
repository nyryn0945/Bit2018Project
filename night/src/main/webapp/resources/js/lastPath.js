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
		ajax: {
			url: "api/subway/getSubwayList",
			dataType: "json",
			processResults: function(data) {
				return {
					results: data
				};
			},
			cache : true
		},
		placeholder: "지하철 선택"
	})
	.on('select2:select', function (e) {
		var data = e.params.data;
		console.log(data);
		$.ajax({
			url: "api/subway/SearchLastTrainTimeByIDService",
			data: {
				station_cd: data.id
			},
			type: "GET",
			dataType: "JSON"
		})
		.done(function(res) {
			console.log(res);
			// buildBusRoute(res);
		})
		.fail(function(err) {
			console.log(err);
		});
	});
	
	$("#busRouteNm").select2({
		ajax: {
			url: "api/bus/getBusRouteList",
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
			url: "api/bus/getStaionByRoute",
			data: {
				busRouteId: data.id
			},
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

var buildBusRoute = function(res) {
	var $wrap = $('#getStaionByRoute');
	$wrap.removeClass('mb-0').addClass('mb-3').html(''); // 내용 초기화
	$.each(res, function(i, item) {
		$('<li>', {
			'class': 'list-group-item list-group-item-action',
			'data-toggle': 'modal',
			'data-target': '#busStationInfoModal'
		})
		.append(
			$('<span>').text(item.stationNm),
			item.lastTm == ':' ? "" : $('<time>').text(item.lastTm)
		)
		.data('data', item)
		.appendTo($wrap);
	});
};
