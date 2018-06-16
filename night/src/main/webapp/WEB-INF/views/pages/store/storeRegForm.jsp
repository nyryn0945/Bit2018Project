<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%@ include file="../../layouts/header.jspf" %>
<link rel="stylesheet" href="/static/css/storeRegForm.css">
<%@ include file="../../layouts/subheader.jspf" %>
      
<div class="container my-5">
	<h3 class="title py-3 text-center font-weight-bold">
		${store != null ? '매장 정보 수정' : '신규 매장 등록'}
	</h3>
	<form action="/night/store/${(store != null) ? 'storeUpdate' : 'storeReg'}" method="POST" enctype="multipart/form-data" onSubmit="return chkForm(this);">
		<c:if test="${store != null}">
		<input type="hidden" name="store_id" value="${store.store_id}">
		</c:if>
		<div class="form-group">
			<label for="cate_id">분류</label>
			<select name="cate_id" class="form-control custom-select" id="cate_id">
				<option value="1"${(store != null && store.cate_id == 1) ? ' selected="selected"' : ''}>숙박</option>
              	<option value="2"${(store != null && store.cate_id == 2) ? ' selected="selected"' : ''}>놀거리</option>
              	<option value="3"${(store != null && store.cate_id == 3) ? ' selected="selected"' : ''}>음식점</option>
			</select>
		</div>
		<div class="form-group">
			<label for="store_name">상호명</label>
			<input type="text" name="store_name" class="form-control" id="store_name" placeholder="상호명" value="${store != null ? store.store_name : ''}">
		</div>
		<div class="form-group">
			<label for="store_name">매장사진</label>
			<div class="custom-file">
			    <input type="file" name="photofile" class="custom-file-input" id="image" accept="image/*" onchange="InputImage();" />
			    <label class="custom-file-label" for="image">${store != null ? store.store_photo : '이미지 선택'}</label>
			</div>
			<div id="imagePreview"${store != null ? ' class="mt-3"' : ''}>
			<c:if test="${store != null}">
			<img src="/night/uploadfile/storephoto/${store.store_photo}" class="img-thumbnail" style="width: 300px;">			
			</c:if>
			</div>
		</div>
		<div class="form-group">
			<label for="store_addr">가게 주소</label>
			<div class="mb-2"><button type="button" class="btn btn-dark" onclick="execDaumPostcode();">우편번호찾기</button></div>
			<input type="hidden" id="postcode" placeholder="우편번호" value="">
			<input type="text" name="store_roadaddr" id="roadAddress" class="mb-2 form-control" placeholder="도로명주소" value="${store != null ? store.store_roadaddr : ''}">
         	<input type="text" name="store_jibunaddr" id="jibunAddress" class="mb-2 form-control" placeholder="지번주소" value="${store != null ? store.store_jibunaddr : ''}">
        	<input type="text" name="store_loc" id="address2" class="form-control" placeholder="상세주소" value="${store != null ? store.store_loc : ''}">
		</div>
		<div class="form-group form-row">
			<div class="col">
				<label for="store_starttime">영업 시작 시간</label>
				<input type="time" name="store_starttime" class="form-control" value="${store != null ? store.store_starttime : ''}">
			</div>
			<div class="col">
				<label for="store_endtime">영업 종료 시간</label>
				<input type="time" name="store_endtime" class="form-control" value="${store != null ? store.store_endtime : ''}">
			</div>
		</div>
		<div class="form-group form-row align-items-center">
			<div class="col col-md-3 col-sm-2">
				<label for="store_pnum">전화번호</label>
				<input type="text" name="store_pnum1" class="form-control mb-2" id="pnum1" value="${store != null ? store.store_pnum1 : ''}">
			</div>
			<div class="col col-md-3 col-sm-2">
				<label for="store_pnum">&nbsp;</label>
				<input type="text" name="store_pnum2" class="form-control mb-2" id="pnum2" value="${store != null ? store.store_pnum2 : ''}">
			</div>
			<div class="col col-md-3 col-sm-2">
				<label for="store_pnum">&nbsp;</label>
				<input type="text" name="store_pnum3" class="form-control mb-2" id="pnum3" value="${store != null ? store.store_pnum3 : ''}">
			</div>
		</div>
		<div class="form-group">
			<label for="store_hp">홈페이지</label>
			<input type="url" name="store_hp" class="form-control" id="store_hp" placeholder="홈페이지" value="${store != null ? store.store_hp : ''}">
		</div>
		<div class="form-group">
			<label for="store_content">정보</label>
			<textarea name="store_content" class="form-control" rows="5" placeholder="내용을 자유롭게 써주세요.">${store != null ? store.store_content : ''}</textarea>
		</div>
		<button type="submit" class="btn btn-dark btn-block">매장 등록</button>
	</form>
</div>

<%@ include file="../../layouts/subfooter.jspf" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/static/js/storeRegForm.js"></script>
<%@ include file="../../layouts/footer.jspf" %>