<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="../../layouts/header.jspf" %>
<style>
.search_01 .searchBox {
    padding: 0 4% 0 4%;
    background-color: #fff;
}
.search_01 .inputArea {
    padding: 10px 0 0;
}
.search_01 .inputArea > div {
    position: relative;
}
.search_01 .inputArea input {
    margin-left: 19px;
    padding-right: 0;
    padding-left: 10px;
}
.search_01 .inputArea > div:before {
    position: absolute;
    left: 0;
    top: 13px;
    width: 19px;
    height: 19px;
    background: url(https://s3-ap-northeast-1.amazonaws.com/dcicons/2018/images/mobile/search/ic-search-input.png) no-repeat;
    background-size: 100% 100%;
    content: '';
}
.inputArea > div {
    position: relative;
    margin: 0 auto;
    padding: 10px 0;
    border-bottom: 1px solid #e6e6eb;
}
.inputArea input {
    display: block;
    margin: auto;
    padding-right: 12%;
    width: 93.63%;
    height: 28px;
    font-size: 20px;
    box-sizing: border-box;
}
input {
    margin: 0;
    padding: 0;
    font-family: 'AppleSDGothicNeo', 'Nanum Barun Gothic', '나눔바른고딕', '나눔고딕','Nanum Gothic','돋움',Dotum,AppleGothic,Arial,sans-serif;
    font-weight: normal;
    line-height: 1.36;
    letter-spacing: 0px;
    text-decoration: none;
    vertical-align: top;
    border: 0;
}
#btn_delete{
	position: absolute;
    width: 40px;
    right: 0px;
    margin-top: -33px;
    display: block;
}
</style>
<%@ include file="../../layouts/subheader.jspf" %>
	<div class="container mt-3">
		<div class="banner">
			<div id="div_banner_top" class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<img src="/night/uploadfile/storephoto/lastnight.png" width="100%;">
					</div>
				</div>
				<div class="swiper-pagination"></div>
			</div>
		</div>
		<div class="search_01" style="margin-bottom:10px;">
			<div class="searchBox" style="padding-bottom:15px;">
				<div class="inputArea">
					<div id="btn_search">
					<form action="/night/store/storeSearchList" method="GET">
						<input id="txt_keyword" type="text" name="query" onclick="location.href='/night/store/storeSearchList';" placeholder="맛집검색하기">
						<button class="submit" style="display:none;"></button>
						</form>
						<img id="btn_delete" src="https://s3-ap-northeast-1.amazonaws.com/dcicons/2018/images/mobile/common/ic-input-cancel@2x.png" style="position:absolute; width:40px; right:0; margin-top:-33px; display:none;">
					</div>
				</div> <!-- inputArea :: end -->
			</div>
		</div>
	</div>
<%@ include file="../../layouts/subfooter.jspf"%>
<%@ include file="../../layouts/footer.jspf"%>