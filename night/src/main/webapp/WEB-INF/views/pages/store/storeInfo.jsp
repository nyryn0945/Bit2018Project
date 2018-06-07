<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>글 읽기</title>
<style>
.iw_inner {
	padding: 10px
}

.iw_inner h3 {
	font-size: 18px;
	padding-bottom: 7px
}

.header {
	color: white;
	background-color: #00CED1;
	height: 150px;
}
.col-6 {
	float: left;
}
</style>
<link rel="stylesheet" href="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/autocomplete.css?2018031306" type="text/css">
</head>
<body>
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
	
	<div class="header">
		<span>${resultstore.store_name}</span>
	</div>	
	
		<hr>
	
	<div>
	<div>
		<h3><img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-profile-facilities@2x.png">${resultstore.cate_name}</h3>
		<h3><img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-profile-address@2x.png">${resultstore.store_loc}</h3>
		<h3><img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-profile-call@2x.png">${resultstore.store_pnum1}-${resultstore.store_pnum2}-${resultstore.store_pnum3}</h3>
	</div>
	<div class="col-6">
		<h1><img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-profile-time@2x.png">영업 시간</h1>
		<h3>영업시작시간:&nbsp;&nbsp;&nbsp;${resultstore.store_starttime}</h3>
		<h3>영업종료시간:&nbsp;&nbsp;&nbsp;${resultstore.store_endtime}</h3>
	</div>
	<div class="col-6">
		<h1><img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-profile-time@2x.png">메뉴 정보</h1>
		<h3>영업시작시간:&nbsp;&nbsp;&nbsp;${resultstore.store_starttime}</h3>
		<h3>영업종료시간:&nbsp;&nbsp;&nbsp;${resultstore.store_endtime}</h3>
	</div>
	<div>
		<h3><img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-profile-tag@2x.png">${resultstore.store_hp}</h3>
		<h3>${resultstore.store_content}</h3>
		<table>
		<tr>
			<td><fmt:formatDate value="${resultstore.store_date}"
					type="date" pattern="YYYY/MM/dd HH:mm" /></td>
					<a href="storeSearchList">목록보기</a> 
		<a href="reply.do?parentId=${article.id}&page=${param.page}">답변쓰기</a> 
		<a href="storeUpdate?store_id=${store.store_id}">수정하기</a> 
		<a href="storeDelete?store_id=${store.store_id}">삭제하기</a>
		</tr>
	</table>
	</div>	
	</div>
	
	
</body>
</html>