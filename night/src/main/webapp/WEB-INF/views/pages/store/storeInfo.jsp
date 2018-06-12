<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="../../layouts/header.jspf" %>
<style>
#search_container_area {
	position: fixed;
	width: 100%;
	height: 56px;
	background-color: rgba(0, 205, 205, 0.85);
	z-index: 99;
	top: 0px;
}

#search_area {
	margin-left: auto;
	margin-right: auto;
	width: 1150px;
	height: 56px;
}

.hide {
	display: none !important;
}

#logo_cell {
	float: left;
	margin: 13px 0px;
	/* margin-right: 77px; */
	margin-right: 118px;
	width: 202px;
	height: 30px;
}

#search_wrapper {
	padding-right: 0px;
	padding-left: 0px;
}

.clearfix:before, .clearfix:after, .dl-horizontal dd:before,
	.dl-horizontal dd:after, .container:before, .container:after,
	.container-fluid:before, .container-fluid:after, .row:before, .row:after,
	.form-horizontal .form-group:before, .form-horizontal .form-group:after,
	.btn-toolbar:before, .btn-toolbar:after, .btn-group-vertical>.btn-group:before,
	.btn-group-vertical>.btn-group:after, .nav:before, .nav:after, .navbar:before,
	.navbar:after, .navbar-header:before, .navbar-header:after,
	.navbar-collapse:before, .navbar-collapse:after, .pager:before, .pager:after,
	.panel-body:before, .panel-body:after, .modal-footer:before,
	.modal-footer:after {
	display: table;
	content: " ";
}

#search_input_wrapper {
	position: relative;
	float: left;
	margin: 13px 0px;
	width: auto;
	height: auto;
}

#logo_img {
	width: 202px;
	height: 30px;
}

#s_input {
	position: relative;
	float: left;
	width: 350px;
	height: 30px;
	font-size: 17px;
	padding: 0px 8px;
	color: rgb(100, 100, 100);
	outline: none;
	background-color: rgb(255, 255, 255);
}

#s_button {
	position: relative;
	float: left;
	width: 30px;
	height: 30px;
	background-image:
		url(https://dcicons.s3.amazonaws.com/dicons/img/main/ms_button.png);
	background-size: 30px 30px;
	background-color: rgb(0, 205, 205);
	outline: none;
}

input {
    -webkit-appearance: none;
    border-radius: 0;
}

input, button, select, textarea {
    font-family: inherit;
    font-size: inherit;
    line-height: inherit;
}

.dropdown {
    position: relative;
}

.dropdown-green button {
    background: transparent;
    outline: 0;
    border: 0;
    width: auto;
}

.label-name {
    width: 90%;
    white-space: nowrap;
    word-wrap: normal;
    max-height: 22px;
    display: block;
    overflow: hidden;
    text-overflow: ellipsis;
    color: #fff;
    /* border: 1px solid #000; */
}

.top-user-name {
    margin-top: 13px;
    margin-right: 49px;
    width: auto !important;
    max-width: 150px;
    text-align: right;
    left: inherit;
    font-weight: bold;
    font-size: 20px;
}

#user_img {
	width: 40px;
	height: 40px;
	/* border: 2px solid #fff; */
	z-index: 11;
}

.top-user-prof img {
    position: relative;
    margin: -2px;
    width: 40px;
    height: 40px;
    border-radius: 100%;
    -moz-border-radius: 100%;
    -webkit-border-radius: 100%;
    box-sizing: border-box;
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
}

.top-user-prof {
    overflow: hidden;
    position: absolute;
    z-index: 11;
    top: 0px;
    right: 0px;
    width: 40px;
    height: 40px;
    background-color: #e0e0e0;
    border-radius: 100%;
    -moz-border-radius: 100%;
    -webkit-border-radius: 100%;
    box-sizing: border-box;
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
    border: 2px solid #fff;
}

.pull-right {
	float: right;
}

.m-top7 {
    margin-top: 7px;
}

.modal *, .box-grid *, .box-grid, .modal, .box-row, .box-row * {
    border-spacing: inherit;
    border-collapse: inherit;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}

#search_wrapper {
	padding-right: 0px;
	padding-left: 0px;
}

.container-fluid {
	padding-right: 15px;
	padding-left: 15px;
	margin-right: auto;
	margin-left: auto;
}

a {
	color: #b9b9b9;
	font-weight: bold;
	text-decoration: none;
}

.iw_inner {
	padding: 10px
}

.iw_inner h3 {
	font-size: 18px;
	padding-bottom: 7px
}

#item-header {
	color: white;
	background-color: rgba(0, 205, 205, 0.9);
	height: 150px;
}

#item-header {
	margin: 0 auto;
}

#item-body {
	width: 100%;
}

#item-body-contents {
	width: 100%;
}

.container {
	width: 1150px;
	margin: 0 auto;
}

#item-rn {
    float: left;
    color: #fff;
    text-align: left;
    width: 100%;
    height: 76px;
    line-height: 76px;
}

.item-rn-title {
	font-size: 36px;
	text-align: left;
	font-weight: 300;
}
/*     
.item-container {
    width: 1150px;
    margin: 0 auto;
    margin-top: 0px;
    margin-right: auto;
    margin-bottom: 0px;
    margin-left: auto;
} */
.item-information {
	display: flex;
	display: -webkit-flex;
	margin-top: 32px;
}

.item-information-text {
	height: 19px;
	font-size: 15px;
	font-weight: normal;
	font-style: normal;
	font-stretch: normal;
	color: #4a4a4a;
	margin-left: 10px;
	flex: 1;
	text-align: left;
}

._flex_1 {
	/*     flex: 1; */
	-webkit-flex: 1;
}

.rest-time {
	margin-right: 60px;
}

.rest-time, .rest-menu {
	padding-left: 32px;
	position: relative;
}

.rest-info-title {
	height: 25px;
	font-size: 24px;
	font-weight: bold;
	font-style: normal;
	font-stretch: normal;
	color: #4a4a4a;
	margin-bottom: 17px;
}

.time {
	height: 19px;
	font-size: 15px;
	font-weight: normal;
	font-style: normal;
	font-stretch: normal;
	text-align: right;
	color: #868686;
}

.r-text {
	height: 18px;
	font-size: 12px;
	font-weight: normal;
	font-style: normal;
	font-stretch: normal;
	text-align: right;
	color: #b9b9b9;
}

.rest-info-wrapper {
	width: 1150px;
	color: #4a4a4a;
	display: flex;
	display: -webkit-flex;
	margin: 0 auto;
	margin-top: 41px;
	margin-bottom: 50px;
	text-align: left;
}

.rest-time-block, .rest-menu-block {
	margin-bottom: 15px;
	background: url(img/profile/main/img-line.png);
	background-repeat: repeat-x;
	position: relative;
	overflow: hidden;
	background-position-y: 7px;
}

.rest-time-left, .rest-menu-left {
	height: 19px;
	font-size: 15px;
	font-weight: 600;
	font-style: normal;
	font-stretch: normal;
	color: #4a4a4a;
	float: left;
	background-color: #ffffff;
	padding-right: 15px;
}

.rest-time-right, .rest-menu-right {
	float: right;
	background-color: #ffffff;
	padding-left: 10px;
}

.rest-time, .rest-menu {
	padding-left: 32px;
	position: relative;
}

.rest-time-block, .rest-menu-block {
	margin-bottom: 15px;
	background: url(img/profile/main/img-line.png);
	background-repeat: repeat-x;
	position: relative;
	overflow: hidden;
	background-position-y: 7px;
}

#enc_info_modify {
	margin: 0 auto;
	width: 1150px;
	background-color: #ffffff;
}

.modify_btn {
	text-align: right;
	margin-bottom: 20px;
	margin-top: 22px;
}

#report_wrong_item {
	display: inline-block;
	font-family: 'Noto Sans KR', 'AppleSDGothicNeo-Regular', 'Nanum Gothic';
	font-size: 14px;
	font-weight: normal;
	font-style: normal;
	font-stretch: normal;
	text-align: right;
	color: #868686;
	cursor: pointer;
}
</style>
<link rel="stylesheet"
	href="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/autocomplete.css?2018031306"
	type="text/css">
<%@ include file="../../layouts/subheader.jspf" %>
	<input type="hidden" name="address" class="form-control" id="address"
		size="20" value="0">
	<script type="text/javascript"
		src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=ZmmkCPbYEQrryHW1Ck0T&submodules=geocoder"></script>
	<div id="map" style="width: 100%; height: 400px;"></div>
	<script>
		var map = new naver.maps.Map('map');
		var myaddress = '${addressName}'; //주소값 받아오기 ex) 강남대로 53
		//var myaddress = '사당동 263-11'; //주소값 받아오기 ex) 강남대로 53

		// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
		naver.maps.Service.geocode({
			address : myaddress
		}, function(status, response) {
			if (status !== naver.maps.Service.Status.OK) {
				return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
			}
			var result = response.result;
			// 검색 결과 갯수: result.total
			// 첫번째 결과 결과 주소: result.items[0].address
			// 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
			var myaddr = new naver.maps.Point(result.items[0].point.x,
					result.items[0].point.y);
			map.setCenter(myaddr); // 검색된 좌표로 지도 이동
			// 마커 표시
			var marker = new naver.maps.Marker({
				position : myaddr,
				map : map
			});
		});
	</script>

	<div id="search_container_area">
		<div id="search_area">
			<form id="search_form" action="#"
				class="ng-pristine ng-valid">
				<div class="hide" id="hidden_wrapper">
					<input type="hidden" id="title_onoff" name="rn" value="0" style="display: none;"> 
					<input type="hidden" id="page" name="page"> 
					<input type="hidden" id="chunk" name="chunk">
					<input type="hidden" id="lat" name="lat" value="37.5144188">
					<input type="hidden" id="lng" name="lng" value="127.01255289999999">
				</div>
				<div class="container-fluid" id="search_wrapper">
					<div id="logo_cell">
						<a href="/night/store/storeMain" style="color:white; font-size:30px; font-weight:bold;">아물</a>
					</div>
					<div class="container-fluid" id="search_input_wrapper">
						<input type="text" id="s_input" name="query" autocomplete="off">
						<button type="submit" id="s_button"></button>
						<div id="ms_ext_area" class="clear board" style="display: none;">
							<div id="list_area" class="list_area">
								<div class="autocomplete-suggestions" style="position: absolute; display: none; width: 395px; max-height: 150px; z-index: 9999;"></div>
							</div>
						</div>
					</div>

					<script type="text/javascript"
						src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/user_menu.js?2018031306"></script>

					<script>
						var w_server = "http://www.diningcode.com/";
						var dicons = "https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/";
					</script>

					<div class="main-top-user box-row pull-right m-top7">
						<div class="dropdown dropdown-green po-relative" id="sessionIn"
							style="display: none;">
							<!-- ng-show="!sessionIn" -->
							<button id="userLabel" type="button" data-toggle="dropdown"
								aria-haspopup="true" aria-expanded="false">
								<span class="label-name top-user-name color-ff" id="user_name" style="margin-top: 13px; max-height: 22px;"></span> 
								<span class="label-name top-user-name color-ff" id="user_intro"	style="margin-top: 13px; max-height: 22px;"></span>

								<div class="top-user-prof">
									<div class="pic-loading-wrap">
										<div class="pic-loader"></div>
									</div>
									<img id="user_img" src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/login/ic_login_setting_user.png">
								</div>
							</button>
						</div>

						<div class="dropdown dropdown-green po-relative" id="sessionOut"
							style="display: block;">
							<!-- ng-show="!sessionOut" -->
							<div onclick="/member/login" style="cursor: pointer;">
								<button type="button">
									<span class="label-name top-user-name color-ff" style="margin-top: 13px; max-height: 22px;">로그인</span>
								</button>
								<div class="top-user-prof">
									<img id="user_img" src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/login/ic_login_setting_user.png">
								</div>
							</div>
						</div>

					</div>

				</div>

			</form>
		</div>
	</div>

	<div id="item-header">
		<div class="item-container" style="width: 1150px;">
			<div id="item-header-top">
				<div id="item-header-left">
					<div id="item-rn">
						<span class="item-rn-title">${resultstore.store_name}</span> 
						<span class="item-rn-divider"></span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div id="item-body">
			<div class="item-container" style="width: 1150px;">
				<div id="item-body-contents">
					<div class='item-information'>
						<div class='item-information-icon'>
							<img src='https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/page/ic-profile-infoowner.png' style="width: 25px; height: 25px;">
						</div>
						<div class='item-information-text'>이 식당의 소유주이신가요?</div>
					</div>
					<div class="item-information">
						<div class="item-information-icon">
							<img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-profile-tag@2x.png" style="width: 25px; height: 25px;">
						</div>
						<div class="item-information-text">
							<span>${resultstore.cate_name}</span>
						</div>
					</div>
					<div class="item-information">
						<div class="item-information-icon">
							<img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-profile-facilities@2x.png" style="width: 25px; height: 25px;">
						</div>
						<div class="item-information-text">
							<span>${resultstore.store_hp}</span>
						</div>
					</div>
					<div class="item-information">
						<div class="item-information-icon">
							<img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-profile-address@2x.png" style="width: 25px; height: 25px;">
						</div>
						<div class="item-information-text">${resultstore.store_jibunaddr}</div>
					</div>
					<div class="item-information" id="item-tel">
						<div class="item-information-icon">
							<img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-profile-call@2x.png" style="width: 25px; height: 25px;">
						</div>
						<div class="item-information-text">${resultstore.store_pnum1}-${resultstore.store_pnum2}-${resultstore.store_pnum3}</div>
					</div>
				</div>
			</div>
		</div>
		<div style="width: 1150px; margin: 0 auto;">
			<div class="rest-info-wrapper" style="flaot: left;">
				<div class="rest-time _flex_1">
					<div class="rest-info-icon">
						<img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-profile-time@2x.png" style="width: 25px; height: 25px;">
					</div>
					<div class="rest-info-title">영업 시간</div>
					<div class="rest-info-contents">
						<div class="rest-time-block">
							<div class="rest-time-left">월-금</div>
							<div class="rest-time-right">
								<div class="time">${resultstore.store_starttime}-${resultstore.store_endtime}</div>
								<div class="r-text">(오더마감 21시30분)</div>
							</div>
						</div>
						<div class="rest-time-block">
							<div class="rest-time-left">휴무일</div>
							<div class="rest-time-right">
								<div class="time">첫째주 화</div>
								<div class="r-text">((짝수달 첫째주 화요일))</div>
							</div>
						</div>
					</div>
				</div>

				<div class="rest-menu _flex_1">
					<div class="rest-info-icon">
						<img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-profile-menu@2x.png" style="width: 25px; height: 25px;">
					</div>
					<div class="rest-info-title">메뉴 정보</div>
					<div class="rest-info-contents">
						<div class="rest-menu-block">
							<div class="rest-menu-left">하이파이브 팬치즈</div>
							<div class="rest-menu-right">
								<div class="time">18,700원</div>
							</div>
						</div>
						<div class="rest-menu-block">
							<div class="rest-menu-left">까망베르치즈치즈</div>
							<div class="rest-menu-right">
								<div class="time">17,600원</div>
							</div>
						</div>
						<div class="rest-menu-block">
							<div class="rest-menu-left">샐러드스파게티</div>
							<div class="rest-menu-right">
								<div class="time">14,300원</div>
							</div>
						</div>
						<div class="rest-menu-block">
							<div class="rest-menu-left">해물 크림리조또</div>
							<div class="rest-menu-right">
								<div class="time">13,200원</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>

		<hr>

		<div class="enc_info_modify">
			<%-- 상세정보:${resultstore.store_content} --%>
			<div class="modify_btn">
				<div id="report_wrong_item" class="modify_item">
					<%-- <a href="storeSearchList">목록보기</a> 
				<a href="reply.do?parentId=${article.id}&page=${param.page}">답변쓰기</a> --%>
					<img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-information-edit@2x.png" style="width: 25px; height: 25px;">
					<a href="storeUpdate?store_id=${store.store_id}">정보 수정</a> 
					<img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-close-store@2x.png" style="width: 25px; height: 25px;">
					<a href="storeDelete?store_id=${store.store_id}">폐업 신고</a>
					<fmt:formatDate value="${resultstore.store_date}" type="date" pattern="YYYY/MM/dd HH:mm" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>