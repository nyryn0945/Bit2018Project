const express = require('express');
const router = express.Router();

const request = require('request');
const convert = require('xml-js');

// var url = "http://ws.bus.go.kr/api/rest/arrive/getArrInfoByRouteAll?serviceKey=GSryg1WDO9jTs4tes4GyOxCzgYpsWcva8HEchoaAoMQ12nxKQpAkoW4z1d0ojSKMVrAGaomCtJOU2Ix0BptOXQ%3D%3D&busRouteId=227000035";

// const p = new Promise((resolve, reject) => {
// 	request(url, (error, response, body) => {
// 		if (!error && response.statusCode == 200) {
// 			resolve(convert.xml2js(body, {compact: true, spaces: 4}));
// 		} else {
// 			reject(error);
// 		}
// 	});
// });

// p.then((json) => {
// 	var arr = json.ServiceResult.msgBody.itemList;
// 	for (var item of arr) {
// 		console.log(item.stNm._text , item.lastTm._text);
// 	}
// })
// .catch((err) => {
// 	console.error(err);
// });

module.exports = router;