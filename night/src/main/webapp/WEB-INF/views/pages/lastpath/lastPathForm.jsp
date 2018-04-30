<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%@ include file="../../layouts/header.jspf" %>
<link rel="stylesheet" href="static/css/lastPath.css">
<%@ include file="../../layouts/subheader.jspf" %>

<main role="main">
	<!-- <div class="jumbotron">
		<div class="container">
			<h1 class="display-3">Hello, world!</h1>
			<p>This is a template for a simple marketing or informational website. It includes a large callout called a jumbotron and three supporting pieces of content. Use it as a starting point to create something more unique.</p>
			<p>
				<a class="btn btn-primary btn-lg" href="#" role="button">Learn more &raquo;</a>
			</p>
		</div>
	</div> -->

	<div class="container mt-3">
		<div class="my-3 p-3 bg-white rounded box-shadow">
			<h5 class="mb-3 font-weight-bold">집에 가자</h5>
			<form class="lastPath" action="${pageContext.request.contextPath}/lastPath" method="post">
				<div class="form-row mb-3">
					<div class="col-md-6">
						<label for="departure_stop">출발지</label>
						<input type="text" name="departure_stop" class="form-control" id="departure_stop" placeholder="출발지">
						<small id="stopHelp" class="form-text text-muted">위치 관련 키워드 또는 주소로 검색</small>
					</div>
					<div class="col-md-6">
						<label for="arrival_stop">도착지</label>
						<input type="text" name="arrival_stop" class="form-control" id="arrival_stop" placeholder="도착지">
					</div>
				</div>
				<button type="submit" class="btn btn-primary">막차 검색</button>
			</form>
		</div>
		
		<div class="my-3 p-3 bg-white rounded box-shadow">
			<h5 class="mb-3 font-weight-bold">지하철 막차 검색</h5>
			<form class="lastPath" action="${pageContext.request.contextPath}/lastTrain" method="post">
				<div class="form-row mb-3">
					<div class="col-md-4">
						<select name="statnFnm" id="statnFnm" class="form-control">
							<option></option>
						</select>
					</div>
				</div>
				<button type="submit" class="btn btn-primary">막차 검색</button>
			</form>
		</div>
		
		<div class="my-3 p-3 bg-white rounded box-shadow">
			<h5 class="mb-3 font-weight-bold">버스 막차 검색</h5>
			<form class="lastPath" action="${pageContext.request.contextPath}/lastPath" method="post">
				<div class="form-row mb-3">
					<div class="col-md-4">
						<!-- <input type="text" name="bus_number" class="form-control" id="bus_number" placeholder="버스번호"> -->
						<select name="busRouteNm" id="busRouteNm" class="form-control">
							<option></option>
						</select>
					</div>
				</div>
				<ul id="getStaionByRoute" class="form-row list-group mb-0"></ul>
			</form>
		</div>
		
	</div>
	<!-- /container -->
</main>

<%@ include file="../../layouts/subfooter.jspf" %>
<script src="static/js/lastPath.js"></script>
<%@ include file="../../layouts/footer.jspf" %>