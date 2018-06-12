<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>매장 정보 수정</title>
<style>
table {
   width: 80%;
}

td {
   padding: 0px 10px;
}
</style>
</head>
<body>

   <h3>매장정보 수정</h3>
   <form action="${pageContext.request.contextPath}/store/storeUpdate" method="post">
      <input type="hidden" name="store_id" value="${stores.store_id}">
      <div>
      	<div>
      	</div>
      </div>
      <table border="1">
         <tr>
            <td>번호</td>
            <td>분류</td>
            <td>이름</td>
            <td>지번</td>   
            <td>등록일자</td>
         </tr>

         <!-- 매장 정보 출력 반복 시작 -->

         <tr>
            <td>${stores.store_id}</td>
            <td>${stores.cate_id}</td>
            <td><input type="text" name="store_name" value="${stores.store_name}"></td>
            <td>${stores.store_jibunaddr }</td>
            <td><fmt:formatDate value="${stores.store_date}" type="date"
                  pattern="yyyy.MM.dd hh:MM" /></td>
             </tr>

         <!-- 회원 정보 출력 반복 끝 -->
      </table>
      <table>
         <tr>
            <td align="center"><input type="submit" value="수정"></td>
            <td><input type="reset" value="취소"></td>
         </tr>
      </table>
   </form>
</body>
</html>