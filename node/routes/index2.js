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

router.get('/api/subway/SearchLastTrainTimeByIDService/:station_cd', (req, res) => {

	var url = "http://openapi.seoul.go.kr:8088/506661546f6e7972313031505571714c/xml/SearchLastTrainTimeByIDService/1/5/";
	url += urlencode(req.params.station_cd)+ "/1/1/";

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

router.get('/api/bus/getBusRouteList/:strSrch', (req, res) => {

	var url = "http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=GSryg1WDO9jTs4tes4GyOxCzgYpsWcva8HEchoaAoMQ12nxKQpAkoW4z1d0ojSKMVrAGaomCtJOU2Ix0BptOXQ%3D%3D&strSrch=";
	url += urlencode(req.params.strSrch);

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

router.get('/api/bus/test', (req, res) => {
	res.json([{
		"id": "100100496",
		"text": "333"
	}, {
		"id": "100100149",
		"text": "1133"
	}, {
		"id": "100100204",
		"text": "2233"
	}, {
		"id": "100100219",
		"text": "3313"
	}, {
		"id": "100100220",
		"text": "3314"
	}, {
		"id": "100100221",
		"text": "3315"
	}, {
		"id": "100100222",
		"text": "3316"
	}, {
		"id": "100100478",
		"text": "3317"
	}, {
		"id": "100100498",
		"text": "3318"
	}, {
		"id": "100100501",
		"text": "3319"
	}, {
		"id": "100100578",
		"text": "3321"
	}, {
		"id": "100100613",
		"text": "3322"
	}, {
		"id": "100100247",
		"text": "4433"
	}, {
		"id": "100100285",
		"text": "5633"
	}, {
		"id": "124000010",
		"text": "8331"
	}, {
		"id": "165000495",
		"text": "6336 (인천)"
	}, {
		"id": "239000110",
		"text": "1330-2 (가평)"
	}, {
		"id": "239000024",
		"text": "1330-44 (가평)"
	}, {
		"id": "239000111",
		"text": "1330-4 (가평)"
	}, {
		"id": "241003280",
		"text": "1336 (고양)"
	}, {
		"id": "207000026",
		"text": "133 (의정부)"
	}, {
		"id": "234000041",
		"text": "330-1 (광주)"
	}, {
		"id": "241003600",
		"text": "3300 (고양)"
	}, {
		"id": "224000047",
		"text": "3300 (시흥)"
	}, {
		"id": "204000084",
		"text": "331 (성남)"
	}, {
		"id": "229000035",
		"text": "333 (파주)"
	}, {
		"id": "227000035",
		"text": "33 (하남)"
	}, {
		"id": "218000108",
		"text": "733 (고양)"
	}, {
		"id": "241000460",
		"text": "8133 (고양)"
	}, {
		"id": "241000300",
		"text": "8433 (시외)"
	}, {
		"id": "208000063",
		"text": "M5333 (안양)"
	}, {
		"id": "241350001",
		"text": "33 (남양주)"
	}, {
		"id": "241350002",
		"text": "33-1 (남양주)"
	}]);
});

router.get('/api/bus/getStaionByRoute/:busRouteId', (req, res) => {

	var url = "http://ws.bus.go.kr/api/rest/busRouteInfo/getStaionByRoute?ServiceKey=GSryg1WDO9jTs4tes4GyOxCzgYpsWcva8HEchoaAoMQ12nxKQpAkoW4z1d0ojSKMVrAGaomCtJOU2Ix0BptOXQ%3D%3D&busRouteId=";
	url += urlencode(req.params.busRouteId);

	console.log(url);

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

router.get('/api/bus/test2', (req, res) => {
	res.json([{
		"stationNm": "하남시위례동행정복지센터",
		"lastTm": ":",
		"lat": "37.4775753528",
		"lng": "127.1509961382",
		"fullSectDist": "0",
		"sectSpd": "0"
	}, {
		"stationNm": "위례고등학교.효성해링턴타워",
		"lastTm": "23:07",
		"lat": "37.4780476428",
		"lng": "127.1485399587",
		"fullSectDist": "220",
		"sectSpd": "3"
	}, {
		"stationNm": "위례중학교.엠코타운센트로엘",
		"lastTm": "23:01",
		"lat": "37.4767755159",
		"lng": "127.147214829",
		"fullSectDist": "220",
		"sectSpd": "9"
	}, {
		"stationNm": "엠코타운플로리체",
		"lastTm": "23:01",
		"lat": "37.4737994576",
		"lng": "127.1492186955",
		"fullSectDist": "470",
		"sectSpd": "20"
	}, {
		"stationNm": "위례롯데캐슬.호반베르디움",
		"lastTm": "23:02",
		"lat": "37.473760682",
		"lng": "127.1510345415",
		"fullSectDist": "160",
		"sectSpd": "11"
	}, {
		"stationNm": "위례호반베르디움",
		"lastTm": ":",
		"lat": "37.4722511906",
		"lng": "127.1542498346",
		"fullSectDist": "460",
		"sectSpd": "18"
	}, {
		"stationNm": "위례센트럴푸르지오",
		"lastTm": ":",
		"lat": "37.4710725933",
		"lng": "127.1540403976",
		"fullSectDist": "130",
		"sectSpd": "15"
	}, {
		"stationNm": "위례센트럴푸르지오.위례푸른초",
		"lastTm": ":",
		"lat": "37.4698683166",
		"lng": "127.151347007",
		"fullSectDist": "290",
		"sectSpd": "9"
	}, {
		"stationNm": "국방전직교육원.밀리토피아시티",
		"lastTm": ":",
		"lat": "37.4673694883",
		"lng": "127.1441245605",
		"fullSectDist": "920",
		"sectSpd": "18"
	}, {
		"stationNm": "창곡동",
		"lastTm": ":",
		"lat": "37.4639381132",
		"lng": "127.1394318599",
		"fullSectDist": "510",
		"sectSpd": "16"
	}, {
		"stationNm": "세곡동",
		"lastTm": ":",
		"lat": "37.4648820415",
		"lng": "127.1094061183",
		"fullSectDist": "2930",
		"sectSpd": "32"
	}, {
		"stationNm": "은곡마을.LH이편한세상",
		"lastTm": "23:14",
		"lat": "37.465344",
		"lng": "127.102535",
		"fullSectDist": "670",
		"sectSpd": "21"
	}, {
		"stationNm": "은곡마을진입로",
		"lastTm": "23:15",
		"lat": "37.465765644",
		"lng": "127.0985783615",
		"fullSectDist": "280",
		"sectSpd": "16"
	}, {
		"stationNm": "세곡푸르지오",
		"lastTm": ":",
		"lat": "37.4650999852",
		"lng": "127.0949599244",
		"fullSectDist": "320",
		"sectSpd": "23"
	}, {
		"stationNm": "헌인마을.서울농업기술센타",
		"lastTm": ":",
		"lat": "37.463226455",
		"lng": "127.0893448195",
		"fullSectDist": "530",
		"sectSpd": "24"
	}, {
		"stationNm": "헌인릉.강남서초예비군훈련장",
		"lastTm": "23:18",
		"lat": "37.4611155017",
		"lng": "127.0826829531",
		"fullSectDist": "630",
		"sectSpd": "32"
	}, {
		"stationNm": "서울특별시어린이병원.강동-송파예비군",
		"lastTm": ":",
		"lat": "37.4575866482",
		"lng": "127.0718263325",
		"fullSectDist": "1030",
		"sectSpd": "34"
	}, {
		"stationNm": "안골마을",
		"lastTm": ":",
		"lat": "37.4562835966",
		"lng": "127.0623888747",
		"fullSectDist": "910",
		"sectSpd": "31"
	}, {
		"stationNm": "서초포레스타입구",
		"lastTm": ":",
		"lat": "37.457779",
		"lng": "127.058987",
		"fullSectDist": "240",
		"sectSpd": "23"
	}, {
		"stationNm": "탑성마을",
		"lastTm": ":",
		"lat": "37.4595286806",
		"lng": "127.0547296866",
		"fullSectDist": "520",
		"sectSpd": "26"
	}, {
		"stationNm": "염곡마을.내곡동주민센터",
		"lastTm": ":",
		"lat": "37.46200197",
		"lng": "127.0491561488",
		"fullSectDist": "560",
		"sectSpd": "12"
	}, {
		"stationNm": "코트라",
		"lastTm": ":",
		"lat": "37.4646377256",
		"lng": "127.0445760316",
		"fullSectDist": "510",
		"sectSpd": "6"
	}, {
		"stationNm": "양재2동주민센터.양재꽃시장",
		"lastTm": ":",
		"lat": "37.4695857229",
		"lng": "127.0394643327",
		"fullSectDist": "730",
		"sectSpd": "10"
	}, {
		"stationNm": "언남고교",
		"lastTm": ":",
		"lat": "37.4732795382",
		"lng": "127.0389281035",
		"fullSectDist": "420",
		"sectSpd": "16"
	}, {
		"stationNm": "교육개발원입구",
		"lastTm": ":",
		"lat": "37.477818",
		"lng": "127.038758",
		"fullSectDist": "500",
		"sectSpd": "21"
	}, {
		"stationNm": "양재역.서초문화예술회관",
		"lastTm": ":",
		"lat": "37.481927",
		"lng": "127.036827",
		"fullSectDist": "490",
		"sectSpd": "18"
	}, {
		"stationNm": "뱅뱅사거리",
		"lastTm": ":",
		"lat": "37.486653",
		"lng": "127.033097",
		"fullSectDist": "660",
		"sectSpd": "11"
	}, {
		"stationNm": "우성아파트",
		"lastTm": ":",
		"lat": "37.491087",
		"lng": "127.030987",
		"fullSectDist": "490",
		"sectSpd": "13"
	}, {
		"stationNm": "강남역",
		"lastTm": ":",
		"lat": "37.4942635569",
		"lng": "127.0296699045",
		"fullSectDist": "370",
		"sectSpd": "13"
	}, {
		"stationNm": "강남역",
		"lastTm": ":",
		"lat": "37.4999348463",
		"lng": "127.0269678944",
		"fullSectDist": "670",
		"sectSpd": "13"
	}, {
		"stationNm": "신논현역.구교보타워사거리",
		"lastTm": ":",
		"lat": "37.502359976",
		"lng": "127.0257902121",
		"fullSectDist": "280",
		"sectSpd": "5"
	}, {
		"stationNm": "교보타워",
		"lastTm": ":",
		"lat": "37.5057773025",
		"lng": "127.0241456343",
		"fullSectDist": "400",
		"sectSpd": "7"
	}, {
		"stationNm": "영동시장논현역",
		"lastTm": ":",
		"lat": "37.5102711129",
		"lng": "127.0220463814",
		"fullSectDist": "530",
		"sectSpd": "16"
	}, {
		"stationNm": "신사동사거리.신사역",
		"lastTm": "23:43",
		"lat": "37.5152837801",
		"lng": "127.0200705571",
		"fullSectDist": "580",
		"sectSpd": "8"
	}, {
		"stationNm": "신사사거리",
		"lastTm": ":",
		"lat": "37.5167928115",
		"lng": "127.0218266895",
		"fullSectDist": "310",
		"sectSpd": "18"
	}, {
		"stationNm": "신사동고개",
		"lastTm": ":",
		"lat": "37.5185545148",
		"lng": "127.0260152561",
		"fullSectDist": "420",
		"sectSpd": "11"
	}, {
		"stationNm": "강남을지병원",
		"lastTm": ":",
		"lat": "37.5183863397",
		"lng": "127.0284882026",
		"fullSectDist": "360",
		"sectSpd": "17"
	}, {
		"stationNm": "학동역",
		"lastTm": ":",
		"lat": "37.5147842255",
		"lng": "127.0301678528",
		"fullSectDist": "420",
		"sectSpd": "18"
	}, {
		"stationNm": "논현동사거리.학동역",
		"lastTm": ":",
		"lat": "37.5138084599",
		"lng": "127.0296697218",
		"fullSectDist": "200",
		"sectSpd": "7"
	}, {
		"stationNm": "영동시장",
		"lastTm": ":",
		"lat": "37.5118508617",
		"lng": "127.0234688746",
		"fullSectDist": "590",
		"sectSpd": "6"
	}, {
		"stationNm": "논현역",
		"lastTm": ":",
		"lat": "37.5091091024",
		"lng": "127.0219545344",
		"fullSectDist": "430",
		"sectSpd": "5"
	}, {
		"stationNm": "반포동",
		"lastTm": ":",
		"lat": "37.505962",
		"lng": "127.023498",
		"fullSectDist": "310",
		"sectSpd": "14"
	}, {
		"stationNm": "신논현역.유화빌딩",
		"lastTm": ":",
		"lat": "37.5015319154",
		"lng": "127.0255490162",
		"fullSectDist": "580",
		"sectSpd": "12"
	}, {
		"stationNm": "강남역티월드",
		"lastTm": ":",
		"lat": "37.4946530306",
		"lng": "127.0288750119",
		"fullSectDist": "820",
		"sectSpd": "15"
	}, {
		"stationNm": "우성아파트",
		"lastTm": ":",
		"lat": "37.491895",
		"lng": "127.030405",
		"fullSectDist": "340",
		"sectSpd": "7"
	}, {
		"stationNm": "뱅뱅사거리",
		"lastTm": ":",
		"lat": "37.487667",
		"lng": "127.032432",
		"fullSectDist": "500",
		"sectSpd": "11"
	}, {
		"stationNm": "양재역.서초문화예술회관",
		"lastTm": ":",
		"lat": "37.48261",
		"lng": "127.035902",
		"fullSectDist": "640",
		"sectSpd": "12"
	}, {
		"stationNm": "교육개발원입구",
		"lastTm": ":",
		"lat": "37.47859",
		"lng": "127.038482",
		"fullSectDist": "510",
		"sectSpd": "19"
	}, {
		"stationNm": "시민의숲",
		"lastTm": ":",
		"lat": "37.473135",
		"lng": "127.038353",
		"fullSectDist": "610",
		"sectSpd": "14"
	}, {
		"stationNm": "AT센터.양재꽃시장",
		"lastTm": ":",
		"lat": "37.468707",
		"lng": "127.039655",
		"fullSectDist": "510",
		"sectSpd": "13"
	}, {
		"stationNm": "하나로마트.코트라",
		"lastTm": ":",
		"lat": "37.4638411943",
		"lng": "127.0444478156",
		"fullSectDist": "680",
		"sectSpd": "10"
	}, {
		"stationNm": "내곡동주민센터",
		"lastTm": ":",
		"lat": "37.461686",
		"lng": "127.04892",
		"fullSectDist": "460",
		"sectSpd": "19"
	}, {
		"stationNm": "탑성마을",
		"lastTm": ":",
		"lat": "37.4583465343",
		"lng": "127.0564153626",
		"fullSectDist": "770",
		"sectSpd": "33"
	}, {
		"stationNm": "서초포레스타입구",
		"lastTm": ":",
		"lat": "37.456753",
		"lng": "127.06016",
		"fullSectDist": "320",
		"sectSpd": "26"
	}, {
		"stationNm": "안골마을",
		"lastTm": "00:25",
		"lat": "37.455227",
		"lng": "127.063892",
		"fullSectDist": "390",
		"sectSpd": "33"
	}, {
		"stationNm": "서울특별시어린이병원.강동-송파예비군",
		"lastTm": "00:26",
		"lat": "37.45667",
		"lng": "127.070372",
		"fullSectDist": "590",
		"sectSpd": "31"
	}, {
		"stationNm": "헌인릉.강남서초예비군훈련장",
		"lastTm": ":",
		"lat": "37.459599266",
		"lng": "127.0795771893",
		"fullSectDist": "880",
		"sectSpd": "52"
	}, {
		"stationNm": "헌인농장",
		"lastTm": "00:26",
		"lat": "37.4614213099",
		"lng": "127.0847576347",
		"fullSectDist": "500",
		"sectSpd": "42"
	}, {
		"stationNm": "헌인마을.서울농업기술센타",
		"lastTm": "00:26",
		"lat": "37.4636402535",
		"lng": "127.0914525016",
		"fullSectDist": "640",
		"sectSpd": "28"
	}, {
		"stationNm": "세곡푸르지오",
		"lastTm": "00:30",
		"lat": "37.465062",
		"lng": "127.096478",
		"fullSectDist": "400",
		"sectSpd": "21"
	}, {
		"stationNm": "세곡리엔파크1단지",
		"lastTm": ":",
		"lat": "37.465433",
		"lng": "127.099922",
		"fullSectDist": "380",
		"sectSpd": "32"
	}, {
		"stationNm": "은곡마을입구.리엔파크2단지",
		"lastTm": ":",
		"lat": "37.465026",
		"lng": "127.102457",
		"fullSectDist": "220",
		"sectSpd": "11"
	}, {
		"stationNm": "대왕초등학교",
		"lastTm": ":",
		"lat": "37.4646708281",
		"lng": "127.1068384861",
		"fullSectDist": "390",
		"sectSpd": "30"
	}, {
		"stationNm": "위례자연앤래미안e편한세상.위례",
		"lastTm": ":",
		"lat": "37.4671717662",
		"lng": "127.1443857185",
		"fullSectDist": "3740",
		"sectSpd": "28"
	}, {
		"stationNm": "위례부영사랑으로후문.위례푸른",
		"lastTm": ":",
		"lat": "37.4697425037",
		"lng": "127.1523485871",
		"fullSectDist": "930",
		"sectSpd": "21"
	}, {
		"stationNm": "위례부영사랑으로정문",
		"lastTm": ":",
		"lat": "37.470814384",
		"lng": "127.1540947971",
		"fullSectDist": "200",
		"sectSpd": "15"
	}, {
		"stationNm": "위례그린파크푸르지오",
		"lastTm": ":",
		"lat": "37.4729411101",
		"lng": "127.1545299257",
		"fullSectDist": "240",
		"sectSpd": "12"
	}, {
		"stationNm": "위례롯데캐슬.호반베르디움",
		"lastTm": ":",
		"lat": "37.4738945555",
		"lng": "127.1519955141",
		"fullSectDist": "300",
		"sectSpd": "21"
	}, {
		"stationNm": "엠코타운플로리체",
		"lastTm": "00:45",
		"lat": "37.4739573541",
		"lng": "127.1500370999",
		"fullSectDist": "170",
		"sectSpd": "9"
	}, {
		"stationNm": "위례중학교.엠코타운센트로엘",
		"lastTm": ":",
		"lat": "37.4770802339",
		"lng": "127.1476676181",
		"fullSectDist": "580",
		"sectSpd": "26"
	}, {
		"stationNm": "위례고등학교.효성해링턴타워",
		"lastTm": ":",
		"lat": "37.4776417021",
		"lng": "127.1493061834",
		"fullSectDist": "260",
		"sectSpd": "17"
	}]);
});

module.exports = router;