/**
 * 길찾기
 * @author Yuri
 */

// Express 기본 모듈 로드
const express = require('express');
const http = require('http');
const path = require('path');

// Express의 미들웨어 로드
const createError = require('http-errors');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const session = require('express-session');
const morgan = require('morgan');
const helmet = require('helmet');
const flash = require('express-flash');
const sassMiddleware = require('node-sass-middleware');

// 설정 파일 불러오기
const config = require('./config/config');


/* ===================
    익스프레스 설정
====================*/
const app = express();

// 헬멧 씌운다
app.use(helmet());

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// 로그 출력
app.use(morgan('dev'));

// body-parser를 이용해 x-www-form, json 파싱
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
	extended: false
}));

// cookie-parser 설정
app.use(cookieParser());

// public 폴더를 static으로 오픈
app.use(sassMiddleware({
	src: path.join(__dirname, 'public'),
	dest: path.join(__dirname, 'public'),
	indentedSyntax: true, // true = .sass and false = .scss
	sourceMap: true
}));
app.use(express.static(path.join(__dirname, 'public')));

// 세션 설정
app.use(session({
	secret: '@Se#ss%ioN&',
	resave: false,
	saveUninitialized: true,
	cookie: {
		secure: true
	}
}));

// 플래시 사용
app.use(flash());

// 라우터 정의
app.use('/', require('./routes/index'));
app.use('/test', require('./routes/test'));

// catch 404 and forward to error handler
app.use((req, res, next) => {
	next(createError(404));
});

// error handler
app.use((err, req, res, next) => {
	// set locals, only providing error in development
	res.locals.message = err.message;
	res.locals.error = req.app.get('env') === 'development' ? err : {};

	// render the error page
	res.status(err.status || 500);
	res.render('pages/error');
});

module.exports = app;