<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%@ include file="../../layouts/header.jspf" %>
<style>
.container {
	width: 600px;
}
button {
    color: #fff;
    background-color: #007bff;
    border-color: #007bff;
    display: inline-block;
    font-weight: 400;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    border: 1px solid transparent;
    padding: .375rem .75rem;
    font-size: 1rem;
    line-height: 1.5;
    border-radius: .25rem;
    transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}
</style>
<%@ include file="../../layouts/subheader.jspf" %>

<main role="main">
	<div class="container mt-3">

<h1>night 메인페이지</h1>

 <button onclick="location.href='storeReg'">매장등록</button>
 <button onclick="location.href='storeSearchList'">장소 매장검색</button>

	</div> <!-- /container -->
</main>

<%@ include file="../../layouts/subfooter.jspf" %>
<%@ include file="../../layouts/footer.jspf" %>