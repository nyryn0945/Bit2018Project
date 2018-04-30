const express = require('express');
const router = express.Router();

// GET localhost/lastpath
router.get('/', (req, res) => {
	res.render('pages/index', {
		title: '안녕'
	});
});

// route localhost/api
router.use('/api', require('./api'));

module.exports = router;