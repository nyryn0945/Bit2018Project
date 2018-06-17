const express = require('express');
const router = express.Router();

const urlencode = require('urlencode');
const request = require('request');
const convert = require('xml-js');
const googleMapsClient = require('@google/maps').createClient({
	key: "AIzaSyBNOXW6jN3IaO-u2gFywBBrRHkQ1z2CIxk",
	Promise: Promise
});

// localhost/api/path/findLastQuickPath
router.get('/findLastQuickPath', (req, res) => {

	const spotArr = [req.query.departure_stop, req.query.arrival_stop];

	// 카카오 API로 좌표 탐색
	const kakaoMapResult = (query) => {
		var options = {
			url: "https://dapi.kakao.com/v2/local/search/keyword.json?query=" + urlencode(query),
			headers: {
				"Authorization": "KakaoAK 748b29a61c3e145b51f8172294a9ddfd"
			}
		};

		return new Promise((resolve, reject) => {
			request(options, (error, response, body) => {
				if (!error && response.statusCode == 200) {
					var json = JSON.parse(body);
					resolve({
						x: json.documents[0].x,
						y: json.documents[0].y
					});
				} else {
					reject(error);
				}
			});
		});
	};

	// 좌표 구하고 경로 계산
	Promise.all(spotArr.map(item => kakaoMapResult(item)))
	.then((kakaoRes) => {
		var d = new Date();
		var hour = d.getHours();
		if (hour > 5) {
			d.setDate(d.getDate() + 1);
		}
		d.setHours(2);
		d.setMinutes(0);
		d.setSeconds(0);

		return googleMapsClient.directions({
			origin: [kakaoRes[0].y, kakaoRes[0].x],
			destination: [kakaoRes[1].y, kakaoRes[1].x],
			alternatives: true,
			mode: 'transit',
			language: 'ko',
			arrival_time: d
		}).asPromise();
	})
	.then((response) => {
		var paths = [];
		var routes = response.json.routes;
		for (var route of routes) {
			var steps = route.legs[0].steps;
			var tempObj = {
				transit: [],
				walking: 0,
				duration: route.legs[0].duration.value
			};
			for (var step of steps) {
				if (step.travel_mode == "TRANSIT") {
					var detail = step.transit_details;
					tempObj.transit.push({
						type: detail.line.vehicle.type,
						short_name: detail.line.short_name,
						duration: step.duration.value,
						departure_stop: detail.departure_stop.name,
						arrival_stop: detail.arrival_stop.name,
						departure_time: new Date(detail.departure_time.value * 1000).toLocaleString("ko-KR", {
							timeZone: "Asia/Seoul"
						}),
						arrival_time: new Date(detail.arrival_time.value * 1000).toLocaleString("ko-KR", {
							timeZone: "Asia/Seoul"
						})
					});
				} else if (step.travel_mode == "WALKING") {
					tempObj.walking += step.duration.value;
				}
			}
			paths.push(tempObj);
		}

		// 도보 시간 오름차순으로 정렬
		paths.sort((a, b) => {
			return a.walking - b.walking;
		});

		return paths;
	})
	.then((paths) => {
		res.json({
			paths: paths
		});
	})
	.catch((err) => {
		console.error(err);
	});
});

// localhost/api/path/searchLastTrainTimeByIDService/:station_cd
router.get('/searchLastTrainTimeByIDService/:station_cd', (req, res) => {

	var urlBase = "http://openapi.seoul.go.kr:8088/506661546f6e7972313031505571714c/json/SearchLastTrainTimeByIDService/1/2/";
	urlBase += urlencode(req.params.station_cd);

	var weekday;
	var date = new Date();
	var n = date.getDay(); // 0: sun, 1: mon, ... 6: sat
	if (n == 0)
		weekday = 3;
	else if (n == 6)
		weekday = 2;
	else
		weekday = 1;

	var urls = [urlBase + "/" + weekday + "/1/", urlBase + "/" + weekday + "/2/"];

	var getJson = (url) => {
		return new Promise((resolve, reject) => {
			request.get(url, (error, response, body) => {
				if (!error && response.statusCode == 200) {
					resolve(JSON.parse(body));
				} else {
					reject(error);
				}
			});
		});
	};

	Promise.all(urls.map(item => getJson(item)))
	.then((arr) => {
		res.status(200).json(arr.map(item => item.SearchLastTrainTimeByIDService.row));
	})
	.catch((err) => {
		console.error(err);
	});
});

router.get('/getBusRouteList', (req, res) => {

	if (req.query.term == undefined || req.query.term == '') {
		res.json({});
		return;
	}

	var url = "http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=GSryg1WDO9jTs4tes4GyOxCzgYpsWcva8HEchoaAoMQ12nxKQpAkoW4z1d0ojSKMVrAGaomCtJOU2Ix0BptOXQ%3D%3D&strSrch=";
	url += urlencode(req.query.term);

	const p = new Promise((resolve, reject) => {
		request(url, (error, response, body) => {
			if (!error && response.statusCode == 200) {
				resolve(convert.xml2js(body, {compact: true, spaces: 4}));
			} else {
				reject(error);
			}
		});
	});

	p.then((json) => {
		var result = [];
		var arr = json.ServiceResult.msgBody.itemList;
		for (var item of arr) {
			var str = item.busRouteNm._text;
			var kor = str.match(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]+/g);
			var num = str.replace(kor, "");
			result.push({
				id: item.busRouteId._text,
				text: num + (kor == null ? "" : " (" + kor[0] + ")")
			});
		}
		res.status(200).json(result);
	})
	.catch((err) => {
		console.error(err);
	});
});

router.get('/getStaionByRoute/:busRouteId', (req, res) => {

	var url = "http://ws.bus.go.kr/api/rest/busRouteInfo/getStaionByRoute?ServiceKey=GSryg1WDO9jTs4tes4GyOxCzgYpsWcva8HEchoaAoMQ12nxKQpAkoW4z1d0ojSKMVrAGaomCtJOU2Ix0BptOXQ%3D%3D&busRouteId=";
	url += urlencode(req.params.busRouteId);

	const p = new Promise((resolve, reject) => {
		request(url, (error, response, body) => {
			if (!error && response.statusCode == 200) {
				resolve(convert.xml2js(body, {compact: true, spaces: 4}));
			} else {
				reject(error);
			}
		});
	});

	p.then((json) => {
		var result = [];
		var arr = json.ServiceResult.msgBody.itemList;
		for (var item of arr) {
			result.push({
				stationNm: item.stationNm._text,
				lastTm: item.lastTm._text,
				lat: item.gpsY._text,
				lng: item.gpsX._text,
				fullSectDist: item.fullSectDist._text,
				sectSpd: item.sectSpd._text
			});
		}
		res.status(200).json(result);
	})
	.catch((err) => {
		console.error(err);
	});
});

module.exports = router;