const express = require('express');
const router = express.Router();

const isLoggedIn = require('../config/function').isLoggedIn;

// GET localhost/test
router.get('/', isLoggedIn, (req, res) => {
	console.log(req.user);
	res.render('pages/test');
});

// GET localhost/test/not
router.get('/not', (req, res) => {
	res.render('pages/test');
});

module.exports = router;