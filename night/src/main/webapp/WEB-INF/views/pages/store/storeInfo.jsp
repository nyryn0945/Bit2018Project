<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="../../layouts/header.jspf"%>
<link rel="stylesheet" href="/static/css/storeInfo.css" />
<%@ include file="../../layouts/subheader.jspf"%>

<div class="container my-2 p-0">
	<div id="map"></div>
	<h4 class="item-header bg-dark text-white p-3">${store.store_name}</h4>
	<div class="item-body p-3 m-3 mx-lg-0 border bg-white rounded">
		<div class="d-flex justify-content-start align-items-center mb-3">
			<div class="p-2 mr-2 badge badge-secondary"><i class="fas fa-tag mr-2"></i>카테고리</div>
			<div class="p-1">${store.cate_name}</div>
		</div>
		<div class="d-flex justify-content-start align-items-center mb-3">
			<div class="p-2 mr-2 badge badge-secondary"><i class="fas fa-home mr-2"></i>홈페이지</div>
			<div class="p-1">${store.store_hp}</div>
		</div>
		<div class="d-flex justify-content-start align-items-center mb-3">
			<div class="p-2 mr-2 badge badge-secondary"><i class="fas fa-location-arrow mr-2"></i>매장주소</div>
			<div class="p-1">${store.store_jibunaddr}</div>
		</div>
		<div class="d-flex justify-content-start align-items-center mb-3">
			<div class="p-2 mr-2 badge badge-secondary"><i class="fas fa-phone-square mr-2"></i>전화번호</div>
			<div class="p-1">${store.store_pnum1}-${store.store_pnum2}-${store.store_pnum3}</div>
		</div>		
		<fmt:parseDate pattern="HH:mm:ss" value="${store.store_starttime}" var="store_starttime" />
		<fmt:parseDate pattern="HH:mm:ss" value="${store.store_endtime}" var="store_endtime" />
		<div class="d-flex justify-content-start align-items-center mb-3">
			<div class="p-2 mr-2 badge badge-secondary"><i class="fas fa-clock mr-2"></i>영업시간</div>
			<div class="p-1">
				<fmt:formatDate value="${store_starttime}" pattern="HH:mm" />
				<span> - </span>
				<fmt:formatDate value="${store_endtime}" pattern="HH:mm" />
			</div>
		</div>
		<c:if test="${store.store_content != ''}">
		<div class="p-3 border rounded bg-light mb-3">${store.store_content}</div>
		</c:if>
		<div class="item-footer border-top pt-3 text-right">
			<a href="/night/store/storeUpdate?store_id=${store.store_id}" class="mr-3"><i class="far fa-edit mr-2"></i>정보수정</a>
			<a href="/night/store/storeDelete?store_id=${store.store_id}" id="delete-store"><i class="fas fa-ban mr-2"></i>폐업신고</a>
		</div>
	</div>
	<%-- 상세정보:${store.store_content} --%>
</div>

<%@ include file="../../layouts/subfooter.jspf"%>
<script src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=ZmmkCPbYEQrryHW1Ck0T&submodules=geocoder"></script>
<script>var myaddress = '${store.store_jibunaddr}';</script>
<script src="/static/js/storeInfo.js"></script>
<%@ include file="../../layouts/footer.jspf"%>