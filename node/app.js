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
const Sequelize = require('sequelize');

// 설정 파일 불러오기
const config = require('./config/config');


/* ===================
  서버 시작 및 DB 연결
====================*/
const models = require('./models/mysql');
models.sequelize.sync();


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

// static으로 오픈 // 근데 이거능 자바에서 오픈할꺼임..
// app.use(express.static(path.join(__dirname, '../night/src/main/webapp/resources')));

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