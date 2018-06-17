<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%@ include file="../../layouts/header.jspf" %>
<style>.container {width: 600px;}</style>
<%@ include file="../../layouts/subheader.jspf" %>

<main role="main">
	<div class="container my-4">
		
		<c:if test="${ERROR_MSG != null}">
		<div class="alert alert-danger mb-3" role="alert">${ERROR_MSG}</div>
		</c:if>
		
		<div class="my-3 p-3 bg-white rounded box-shadow">
			<h5 class="mb-3 font-weight-bold">로그인</h5>
			<form action="/member/login" method="post">
				<div class="form-group row">
					<label class="col-sm-2 col-form-label" for="username">아이디</label>
					<div class="col-sm-10">
						<input type="text" name="username" class="form-control" id="username" placeholder="아이디">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2 col-form-label" for="password">비밀번호</label>
					<div class="col-sm-10">
						<input type="password" name="password" class="form-control" id="password" placeholder="비밀번호">
					</div>
				</div>
				<button type="submit" class="btn btn-primary">Submit</button>
			</form>
		</div>
	</div> <!-- /container -->
</main>

<%@ include file="../../layouts/subfooter.jspf" %>
<%@ include file="../../layouts/footer.jspf" %>