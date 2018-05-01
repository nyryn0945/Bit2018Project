const express = require('express');
const router = express.Router();

//const models = require('../models/mysql');
// router.get('/', (req, res) => {
// 	models.Subway.findAll({
// 		attributes: ['subway_id', 'station_NM'],
// 		where: {
// 			subway_id: 2
// 		},
// 		raw: true
// 	})
// 	.then((subs) => {
// 		console.log(subs);
// 		res.json(subs);
// 	});
// });

module.exports = router;