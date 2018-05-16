/*
 * function.js
 */
const passport = require('passport');

exports.isLoggedIn = (req, res, next) => {
	if (req.isAuthenticated())
	return next();

	req.body.sessionName = req.cookies.JSESSIONID;
	req.body.temp = "temp";
	passport.authenticate('local', (err, user, info) => {
		if (err) return next(err);
		if (!user) return res.redirect('/member/login');
		req.logIn(user, (err) => {
			if (err) return next(err);
			return next();
		});
	})(req, res, next);
};