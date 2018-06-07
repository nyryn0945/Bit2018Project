<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title>NIGHT 매장등록</title>
<style>
html, body { margin:0; padding:0; }
.body {
   font-family:MalgunGothic;
}
.row {
   width:1140px;
   margin:0 auto;
   padding-left:250px;
}
.layer_white {
   position:relative;
   color:#222222;
}
.layer_black {
   background-color:#222222;
   color:#222222;
}
.title {
   font-size:15px;
   font-weight:bold;
}

.addrdiv{
padding:0; margin:0
}

input[type=text] {
   margin:5px 0 0px 0;
   width:90%;
   height:40px;
   border:#222222 solid 1px;
}

input[type=time] {
   margin:5px 0 20px 0;
   width:90%;
   height:40px;
   border:#222222 solid 1px;
}
    
input[type=button] {
   margin:5px 0 5px 0;
   width:30%;
   height:40px;
   border:#222222 solid 1px;
}

#pnum{
    margin:15px 0 20px 0;
   width:20%;
   height:40px;
   border:#222222 solid 1px;
}


input::-webkit-input-placeholder { color:#999999;  text-align: center;}
input::-moz-placeholder { color:#999999; }
input::-ms-input-placeholder { color:#999999; }
textarea::-webkit-input-placeholder { color:#999999; }
textarea::-moz-placeholder { color:#999999; }
textarea::-ms-input-placeholder { color:#999999; }

</style>
<script type="Text/JavaScript">

function chkForm(obj) {
   if( !obj.store_name.value ) {
      alert("상호명을 입력해 주세요.");
      obj.store_name.focus();
      return false;
   }
   if( !obj.store_roadaddr.value ) {
      alert("도로명주소를 입력해 주세요.");
      obj.store_roadaddr.focus();
      return false;
   }
    if( !obj.store_jibunaddr.value ) {
      alert("지번주소를 입력해 주세요.");
      obj.store_jibunaddr.focus();
      return false;
   }
    if( !obj.store_loc.value ) {
      alert("상세주소를 입력해 주세요.");
      obj.store_loc.focus();
      return false;
   }
   if( !obj.store_starttime.value ) {
      alert("영업 시작 시간을 입력해 주세요.");
      obj.store_starttime.focus();
      return false;
   }
   if( !obj.store_endtime.value ) {
      alert("영업 종료 시간을 입력해 주세요.");
      obj.store_endtime.focus();
      return false;
   }
   if( !confirm("매장을 등록 하시겠습니까?") ) {
      return false;
   }
}

</script>
</head>
<body>
<div class="warp" style="100%;">

   <div class="layer_white">
      <div class="row" style="padding-top:30px;">
         <div style="font-family:NanumMyeongjo; font-size:23px;">
            <strong>매장 등록 페이지 입니다.</strong><br />
            방문지역이 명확하여 마케팅에 효과적인 서비스입니다."
         </div>
      </div>
      </div>
   </div>
   <div class="layer_white">
      <div class="row" style=" padding-bottom:46px;">
         <div class="clear"></div>
      </div>
   </div>

   <div class="layer_black">
      <div style="width:460px; margin:0 auto; padding-top:50px">
         <div style="background-color:#FFFFFF; padding:30px 15px;">
            <div style="margin-bottom:30px; text-align:center; font-weight:bold; font-size:27px;">신규 매장등록</div>
            <form name="" method="POST" onSubmit="return chkForm(this);">
                <div class="title" >분류</div><br>
                <select name="cate_id" style="font-size:18px;">
			     <option value="1">숙박</option>
			     <option value="2">놀거리</option>
			     <option value="3">음식점</option>
			    </select>
                <br><br>
                <div class="title">상호명</div>
               <input type="text" name="store_name" style="font-size:18px;" value="" placeholder="상호명"/><br><br>
               <div class="title">가게주소</div>
                
                <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample4_roadAddress').value = fullRoadAddr;
                document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    //예상되는 도로명 주소에 조합형 주소를 추가한다.
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
</script>
			<div class="addrdiv"><input type="text" id="sample4_postcode" placeholder="우편번호" style="font-size:18px;" value="">
			<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
			<input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="store_roadaddr" style="font-size:18px;" value="">
			<input type="text" id="sample4_jibunAddress" placeholder="지번주소" name="store_jibunaddr" style="font-size:18px;" value="">
			<input type="text" placeholder="상세주소" name="store_loc"  style="font-size:18px;" value="">
			<span id="guide" style="color:#999"></span>
			</div><br>

                
               <div class="title">영업 시작 시간</div>
               <input type="time" name="store_starttime" style="font-size:18px;" value="" />
                <div class="title">영업 종료 시간</div>
               <input type="time" name="store_endtime" style="font-size:18px;" value="" />
               <div class="title">전화번호</div>
               <input type="text" id="pnum" name="store_pnum1" style="font-size:18px;"> -
                <input type="text" id="pnum" name="store_pnum2" style="font-size:18px;"/> -
                <input type="text" id="pnum" name="store_pnum3" style="font-size:18px;"/>
                <div class="title">홈페이지 주소</div>
               <input type="text" name="store_hp" style="font-size:20px;" value="" />
                <br><br>
               <div class="title">정보</div>
               <textarea name="store_content" style="font-size:18px; padding:10px; width:90%; height:200px; border:#222222 solid 1px; margin-top:15px;" placeholder="내용을 자유롭게 써주세요."></textarea>
               <button type="submit" style="margin-top:30px; width:100%; height:50px; background-color:#222222; color:#FFFFFF; font-size:16px; border-radius:2px; border:none; cursor:pointer;">매장 등록</button>
            </form>
         </div>
      </div>
      <div style="width:460px; margin:0 auto; padding-top:30px; padding-bottom:30px;">
   </div>
</div>
</body>
</html>