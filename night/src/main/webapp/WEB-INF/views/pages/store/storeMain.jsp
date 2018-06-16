<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="../../layouts/header.jspf"%>
<link rel="stylesheet" href="/static/css/storeSearchList.css" />
<%@ include file="../../layouts/subheader.jspf"%>

<div class="container my-4">
	<div class="mb-3">
		<img src="/static/img/lastnight.png" class="img-fluid">
	</div>
	<form id="store-search" class="border rounded p-3 bg-white">
		<div class="input-group">
			<input type="text" name="searchStore" class="form-control" id="searchStore" placeholder="주소" required>
			<div class="input-group-append">
				<button type="submit" class="btn btn-dark">검색</button>
			</div>
		</div>
	</form>
	<ul id="store-list" class="list-group mt-3"></ul>
	<button type="button" id="btn-view-more" class="btn btn-dark btn-block mt-3 d-none">더보기</button>
</div>

<%@ include file="../../layouts/subfooter.jspf"%>
<script src="/static/js/storeSearchList.js"></script>
<%@ include file="../../layouts/footer.jspf"%>