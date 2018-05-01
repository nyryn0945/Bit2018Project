const express = require('express');
const router = express.Router();

const models = require('../models/mysql');

// GET localhost/lastpath
router.get('/', (req, res) => {
	models.Subway.findAll({
		attributes: ['station_cd', 'station_nm', 'line_num'],
		raw: true
	})
	.then((results) => {
		var list = [];
		for (var item of results) {
			var text = item.station_nm.replace("\\((.*?)\\)", "") + convertLineNum(item.line_num);
			list.push({
				id: item.station_cd,
				text: text
			});
		}
		res.render('pages/index', {
			list: list
		});
	});

	const convertLineNum = (line_num) => {
		var str = "";
		if (line_num == "SU") { // SU, UI, KK, I2
			str = "수인선";
		}
		else if (line_num == "UI") {
			str = "우이신설경전철";
		}
		else if (line_num == "KK") {
			str = "경강선";
		}
		else if (line_num == "I2") {
			str = "인천 2호선";
		}
		else {
			var num = line_num.charAt(0);
			switch (num) {
				case 'A':
					str = "공항철도";
					break;
				case 'B':
					str = "분당선";
					break;
				case 'E':
					str = "용인경전철";
					break;
				case 'G':
					str = "경춘선";
					break;
				case 'I':
					str = "인천1호선";
					break;
				case 'K':
					str = "경의중앙선";
					break;
				case 'S':
					str = "신분당선";
					break;
				case 'U':
					str = "의정부경전철";
					break;
				default:
					str = num + "호선";
					break;
			}
		}
		
		return " (" + str + ")";
	};
});

// route localhost/api
router.use('/api', require('./api'));

module.exports = router;