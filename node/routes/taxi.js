const express = require('express');
const router = express.Router();

const isLoggedIn = require('../config/function').isLoggedIn;
const urlencode = require('urlencode');
const request = require('request');
const Taxi = require('../models/mongo/taxi_schema');

// GET localhost/taxi
router.get('/', isLoggedIn, (req, res) => {
	res.render('pages/taxi', {
		user: req.user
	});
});

module.exports = function(io) {
	io.on('connection', (socket) => {
		// 출발/도착지 전송 받았을 때
		// 0. 이미 전송된 회원이면 요청 취소할꺼냐 물어봐야함
		// 1. 좌표값 계산
		// 2. 현재 DB에서 출발/도착 좌표 비슷한 놈 찾고
		// 3 - 1. 있으면 연결해서 채팅 연결
		// 3 - 2. 없으면 DB에 등록한 뒤 안내 메시지 출력
		socket.on('find mate', (data) => {
			data.socketId = socket.id;

			Promise.all([data.departure.name, data.arrival.name].map(item => kakaoMapResult(item)))
			.then((locs) => {
				// api 낭비 막기 위한 임시 설정
				locs = [ { lng: 127.02800178194782, lat: 37.498083647347194 },
					{ lng: 127.15528203843505, lat: 37.47378208157996 } ];

				data.departure.loc = {coordinates: [locs[0].lng, locs[0].lat]};
				data.arrival.loc = {coordinates: [locs[1].lng, locs[1].lat]};
				return Promise.all(['d', 'a'].map(item => Taxi.search(item, data)));
			})
			.then((results) => {
				var resArr = [];
				const dRes = results[0];
				const aRes = results[1];
				for (var i of dRes) {
					for (var j of aRes) {
						if (i._id.toString() == j._id.toString())
							resArr.push(i);
					}
				}
				return resArr;
			})
			.then((resArr) => {
				if (resArr.length == 0) {
					// 찾지 못하면 DB에 요청 추가하고 대기
					Taxi.add(data);
				}
				else {
					// 찾았으면 해당 데이터 DB에서 삭제하고
					Taxi.deleteById(resArr[0]._id);

					// 클라이언트에게 전송해서 오픈채팅 열어준다
					var roomName = 'room' + Math.floor((Math.random() * 100000) + 1);
					io.sockets.connected[resArr[0].socketId].join(roomName);
					socket.join(roomName);
					io.in(roomName).emit('chat open', roomName);
				}
			});
		});

		// 종료 명령 들어왔을때
		socket.on('find exit', () => {
			Taxi.deleteBySocketId(socket.id);
		});

		// 채팅채팅
		socket.on('chat message', (data) => {
			var username = socket.handshake.session.passport.user.username;
			io.in(data.roomName).emit('chat message', {
				sender: username,
				message: data.message
			});
		});

		// 채팅 종료시
		socket.on('chat exit', (roomName) => {
			// 다른 쪽도 채팅 종료하도록
			socket.broadcast.to(roomName).emit('chat exit');
			// 룸 청소
			io.in(roomName).clients((err, clients) => {
				clients.forEach((s) => {
					io.sockets.sockets[s].leave(roomName);
				});
			});
		});
	});

	return router;
};

// 카카오 API로 좌표 탐색
const kakaoMapResult = (query) => {

	// api 낭비 막기 위한 임시 설정
	return [];

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
					lng: parseFloat(json.documents[0].x),
					lat: parseFloat(json.documents[0].y)
				});
			} else {
				reject(error);
			}
		});
	});
};