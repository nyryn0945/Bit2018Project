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
	$('.findLastQuickPath').submit(function(e) {
		e.preventDefault();
		var $this = $(this);
		$.ajax({
			// url: 'api/path/test',
			url: 'api/path/findLastQuickPath',
			data: $this.serialize(),
			type: 'GET',
			dataType: 'JSON'
		})
		.done(function(res) {
			buildPath(res.paths);
		})
		.fail(function(err) {
			console.log(err);
		});
	});
	
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

var buildPath = function(path) {
	var $wrap = $('#findLastQuickPath');
	$wrap.removeClass('mb-0').addClass('mt-3').html('');
	
	$.each(path, function(i, item) {
		$('<li>', {'class': 'list-group-item list-group-item-secondary'})
		.append(
			$('<h6>', {class: 'float-left'}).text((i + 1) + '번째 루트'),
			$('<small>', {class: 'float-right'}).text('도보 ' + Math.round(item.walking / 60) + '분 / 총 ' + Math.round(item.duration / 60) + '분')
		)
		.appendTo($wrap);
		var trans = item.transit;
		$.each(trans, function(i2, item2) {
			var len1 = item2.departure_time.length;
			var len2 = item2.arrival_time.length;
			$('<li>', {'class': 'list-group-item'})
			.append(
				$('<div>', {class: 'subName'}).append(
					$('<span>').text(item2.departure_stop),
					$('<small>', {class: 'text-muted'}).text(item2.departure_time.substring(len1 - 9, len1 - 3)),
					$('<i class="fas fa-long-arrow-alt-right text-primary ml-2 mr-2"></i>'),
					$('<span>').text(item2.arrival_stop),
					$('<small>', {class: 'text-muted'}).text(item2.arrival_time.substring(len2 - 9, len2 - 3)),
				),
				$('<div>', {class: 'time'}).append(
					$('<small>', {class: 'text-primary mr-2'}).text(item2.type == 'BUS' ? '버스' : '지하철'),
					$('<small>').text(item2.short_name),
					$('<small>', {class: 'text-primary ml-3 mr-2'}).text('소요시간'),
					$('<small>').text(Math.round(item2.duration / 60) + '분')				
				)
			)
			.appendTo($wrap);
		});
	});
};

var buildLastSubway = function(res) {
	var $wrap = $('#searchLastTrainTimeByID');
	$wrap.removeClass('mb-0').html('');
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
	$wrap.removeClass('mb-0').html(''); // 내용 초기화
	$.each(res, function(i, item) {
		$('<li>', {'class': 'list-group-item list-group-item-action'})
		.append(
			$('<span>').text(item.stationNm),
			item.lastTm == ':' ? "" : $('<time>', {class: 'text-primary ml-2'}).text(item.lastTm)
		)
		.appendTo($wrap);
	});
};
