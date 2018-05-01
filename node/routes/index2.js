const express = require('express');
const router = express.Router();

const urlencode = require('urlencode');
const request = require('request');
const convert = require('xml-js');
const googleMapsClient = require('@google/maps').createClient({
	key: "AIzaSyBlXEl9ShyPbgaAKl7R2LDg2DiOByz81q0",
	Promise: Promise
});

router.get('/', (req, res) => {
	res.render('pages/index');
});

// http://localhost:3000/api
router.get('/api', (req, res) => {
	const kakaoObj = {
		dp: {},
		ar: {}
	};

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
	kakaoMapResult("강남역 2호선")
		.then((result) => {
			kakaoObj.dp = result;
			return kakaoMapResult("위례 그린파크 푸르지오");
		})
		.then((result) => {
			kakaoObj.ar = result;
			return googleMapsClient.directions({
				origin: [kakaoObj.dp.y, kakaoObj.dp.x],
				destination: [kakaoObj.ar.y, kakaoObj.ar.x],
				alternatives: true,
				mode: 'transit',
				language: 'ko',
				arrival_time: new Date('2018-04-20 02:00:00')
			}).asPromise();
		})
		.then((response) => {
			var paths = [];
			var routes = response.json.routes;
			for (var route of routes) {
				var steps = route.legs[0].steps;
				var tempObj = {
					transit: [],
					walking: 0
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
			console.log(err);
		});
});

router.get('/apitest', (req, res) => {
	res.json({
		"paths": [{
			"transit": [{
				"type": "BUS",
				"short_name": "33",
				"duration": 2955,
				"departure_stop": "신분당선강남역",
				"arrival_stop": "위례그린파크푸르지오",
				"departure_time": "2018-4-20 00:05:51",
				"arrival_time": "2018-4-20 00:55:06"
			}],
			"walking": 497
		}, {
			"transit": [{
				"type": "BUS",
				"short_name": "440",
				"duration": 2965,
				"departure_stop": "신분당선강남역",
				"arrival_stop": "위례중앙푸르지오.신안인스빌",
				"departure_time": "2018-4-20 00:21:18",
				"arrival_time": "2018-4-20 01:10:43"
			}],
			"walking": 1300
		}, {
			"transit": [{
				"type": "BUS",
				"short_name": "452",
				"duration": 2541,
				"departure_stop": "신분당선강남역",
				"arrival_stop": "민속마을.선경아파트",
				"departure_time": "2018-4-20 00:17:45",
				"arrival_time": "2018-4-20 01:00:06"
			}],
			"walking": 1517
		}, {
			"transit": [{
				"type": "SUBWAY",
				"short_name": "2호선",
				"duration": 660,
				"departure_stop": "강남역",
				"arrival_stop": "잠실",
				"departure_time": "2018-4-20 00:16:30",
				"arrival_time": "2018-4-20 00:27:30"
			}, {
				"type": "SUBWAY",
				"short_name": "8호선",
				"duration": 840,
				"departure_stop": "잠실역",
				"arrival_stop": "산성",
				"departure_time": "2018-4-20 00:39:00",
				"arrival_time": "2018-4-20 00:53:00"
			}],
			"walking": 2420
		}]
	});
});

module.exports = router;