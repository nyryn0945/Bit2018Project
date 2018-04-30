<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<%@ include file="../../layouts/header.jspf"%>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/lastPath.css"> --%>
<%@ include file="../../layouts/subheader.jspf"%>

<main role="main">

<div class="container mt-3">
	<div class="my-3 p-3 bg-white rounded box-shadow">
		<h2>게시글(리뷰)작성</h2>
		<form action="${pageContext.request.contextPath}/review" method="post">
			<br>
			<div>
				<textarea name="REVIEW_CONTENT" id="REVIEW_CONTENT" rows="4"
					cols="125" placeholder="내용을 입력해주세요."></textarea>
			</div>
			<div style="text-align: right">
				<input type="hidden" name="MB_ID" value="1">
				<input type="hidden" name="STORE_ID" value="1">
                <input type="submit" value="등록"> 
                <input type="reset">

			</div>
		</form>
	</div>
    <div class="my-3 p-3 bg-white rounded box-shadow">
        <h2>리뷰 리스트</h2>
        <table border = "1" width = "600px">
        <tr>
           <th>번호(사용자)</th>
           <th>내용</th>
           <th>등록날짜</th>
           <th></th>
         </tr>  
           <!-- 리뷰 내용 출력 -->
           <c:forEach var = "review" items ="${review}">
            <tr>
                <td>${review.MB_ID}</td>
                <td>${review.REVIEW_CONTENT}</td>
                <td>${review.REVIEW_DATE}</td>
                <td>
                  <a href = "reviewUpdate?MB_ID=${review.MB_ID }">수정</a>
                  <a href = "reviewDelete?MB_ID=${review.MB_ID }">삭제</a>
                
                </td>
                 
                
           </tr>
           </c:forEach>

      </table>
    </div>
</div>

<!-- /container --> 
</main>



<%@ include file="../../layouts/subfooter.jspf"%>
<%-- <script src="${pageContext.request.contextPath}/js/lastPath.js"></script> --%>
<%@ include file="../../layouts/footer.jspf"%>