const express = require('express');
const router = express.Router();

// localhost/api/path
router.use('/path', require('./path'));

module.exports = router;