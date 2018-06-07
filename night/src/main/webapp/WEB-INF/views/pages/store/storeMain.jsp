<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="../../layouts/header.jspf" %>
<style>.container {width: 600px;}</style>
<%@ include file="../../layouts/subheader.jspf" %>
	<div class="container mt-3">
		<div id="div_new" style="position: absolute; top: 100px; left:50%; width: 552px; margin-top: 200px; margin-left: -276px; z-index: 1;">
			<!-- 메인 로고 <img src="img/3%EB%9A%9D.png" id="logo1_img" alt="logo1" style="margin-bottom:30px;" width="25%" /> -->
			<script	src='https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/autocomplete.js?2018031306'></script>
			<script type="text/javascript" src="/search.js?2018031306"></script>
			<script type="text/javascript" src="/location.js?2018031306"></script>
			<div id="pop_sub_area">
				<button type="submit" class="ml-sm-2 btn btn-primary" style="width: 500px; align:center" onclick="location.href='/night/store/storeSearchList'">
					<img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/ic-search-input.png" />
				</button>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		
	</script>

<%@ include file="../../layouts/subfooter.jspf"%>
<%@ include file="../../layouts/footer.jspf"%>