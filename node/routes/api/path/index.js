const express = require('express');
const router = express.Router();

// localhost/api/path
router.get('/', (req, res) => {
	res.json({
		test: true
	});
});

module.exports = router;