<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%@ include file="./layouts/header.jspf" %>
<style>.container {width: 600px;}</style>
<%@ include file="./layouts/subheader.jspf" %>

<main role="main">
	<div class="container mt-3">
		<div class="alert alert-primary" role="alert">
		${MEMBER}<br>
		${SESSION}
		</div>
		<a class="btn btn-primary" href="/night/login" role="button">로그인</a>
		<a class="btn btn-primary" href="/night/logout" role="button">로그아웃</a>
	</div> <!-- /container -->
</main>

<%@ include file="./layouts/subfooter.jspf" %>
<%@ include file="./layouts/footer.jspf" %>