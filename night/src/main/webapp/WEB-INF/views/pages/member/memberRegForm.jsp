<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%@ include file="../../layouts/header.jspf" %>
<style>.container {width: 600px;}</style>
<%@ include file="../../layouts/subheader.jspf" %>

<main role="main">
	<div class="container mt-3">
		
		<c:if test="${ERROR_MSG != null}">
		<div class="alert alert-danger mb-3" role="alert">${ERROR_MSG}</div>
		</c:if>
		
		<div class="my-3 p-3 bg-white rounded box-shadow">
			<h5 class="mb-3 font-weight-bold">회원가입</h5>
			<form action="/member/register" method="post">
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
				<div class="form-group row">
					<label class="col-sm-2 col-form-label" for="nickname">닉네임</label>
					<div class="col-sm-10">
						<input type="text" name="nickname" class="form-control" id="nickname" placeholder="닉네임">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2 col-form-label" for="email">이메일</label>
					<div class="col-sm-10">
						<input type="email" name="email" class="form-control" id="email" placeholder="이메일">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2 col-form-label" for="pnum">전화번호</label>
					<div class="col-sm-10">
						<input type="text" name="pnum" class="form-control" id="pnum" placeholder="전화번호">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2 col-form-label" for="address">주소</label>
					<div class="col-sm-10">
						<input type="text" name="address" class="form-control" id="address" placeholder="주소">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2 col-form-label" for="gender">성별</label>
					<div class="col-sm-10">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="gender" id="gender1" value="0">
							<label class="form-check-label" for="gender1">남성</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="gender" id="gender2" value="1">
							<label class="form-check-label" for="gender2">여성</label>
						</div>
					</div>
				</div>
				<button type="submit" class="btn btn-primary">Submit</button>
			</form>
		</div>
	</div> <!-- /container -->
</main>

<%@ include file="../../layouts/subfooter.jspf" %>
<%@ include file="../../layouts/footer.jspf" %>