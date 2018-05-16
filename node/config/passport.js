const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const redis = require('redis');
const client = new redis.createClient();

module.exports = (passport) => {
	// 사용자 인증 성공 시 호출
	// 사용자 정보를 이용해 세션을 만듦
	passport.serializeUser((user, done) => {
		// console.log('serializeUser() 호출됨.', user);
		done(null, user);
	});

	// 사용자 인증 이후 사용자 요청 시마다 호출
	passport.deserializeUser((user, done) => {
		// console.log('deserializeUser() 호출됨.', user);
		done(null, user);
	});

	// 인증방식 설정
	passport.use(new LocalStrategy({
		usernameField: 'sessionName',
		passwordField: 'temp'
	}, (username, password, done) => {
		client.hgetall("spring:session:sessions:" + username, (err, obj) => {
			if (err) return done(err);

			if (obj == null ||!obj.hasOwnProperty('sessionAttr:MEMBER') || obj['sessionAttr:MEMBER'] == '')
				return done(null, false);

			return done(null, JSON.parse(obj['sessionAttr:MEMBER']));
		});
	}));
};