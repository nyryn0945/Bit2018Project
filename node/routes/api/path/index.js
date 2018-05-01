const express = require('express');
const router = express.Router();

const urlencode = require('urlencode');
const request = require('request');
const convert = require('xml-js');
const googleMapsClient = require('@google/maps').createClient({
	key: "AIzaSyBlXEl9ShyPbgaAKl7R2LDg2DiOByz81q0",
	Promise: Promise
});
const models = require('../../../models/mysql');

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