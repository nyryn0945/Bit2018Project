<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%@ include file="../../layouts/header.jspf" %>
<style>.container {width: 600px;}</style>
<%@ include file="../../layouts/subheader.jspf" %>

<main role="main">
	<div class="container mt-3">

<h1>night 메인페이지</h1>

<ul>
	
	<li> <a href="storeReg">매장등록 (form)</a> </li>
	<li> <a href="storeList">매장목록 (form)</a> </li>
	<li> <a href="storeDelete">매장삭제 (form)</a> </li>
	<li> <a href="storeSearchList">장소 매장검색 (form)</a></li>
</ul>
	</div> <!-- /container -->
</main>

<%@ include file="../../layouts/subfooter.jspf" %>
<%@ include file="../../layouts/footer.jspf" %>