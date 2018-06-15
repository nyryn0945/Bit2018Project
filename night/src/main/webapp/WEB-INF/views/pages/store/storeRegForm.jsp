<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%@ include file="../../layouts/header.jspf" %>

<style>
.container>*{
	max-width: 100%;
}
.body {
   font-family:MalgunGothic;
}
.row {
   width:1140px;
   margin:0 auto;
   padding-left:250px;
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
   width:100%;
   height:40px;
   border:#222222 solid 1px;
}

input[type=time] {
   margin:5px 0 20px 0;
   width:100%;
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
   border-radius: 5px 5px 5px 5px;
   width:20%;
   height:40px;
   border:#222222 solid 1px;
}
    
    .filebox input[type="file"]{
        position: absolute;
        width: 1px;
        height: 1px;
        padding: 0;
        margin: -1px;
        overflow: hidden;
        clip:rect(0,0,0,0);
        border: 0;
    }


input::-webkit-input-placeholder { color:#999999;  text-align: center;}
input::-moz-placeholder { color:#999999; }
input::-ms-input-placeholder { color:#999999; }
textarea::-webkit-input-placeholder { color:#999999; }
textarea::-moz-placeholder { color:#999999; }
textarea::-ms-input-placeholder { color:#999999; }

</style>
<script type="text/JavaScript">

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
var InputImage = 
   (function loadImageFile() {
    if (window.FileReader) {
        var ImagePre; 
        var ImgReader = new window.FileReader();
        var fileType = /^(?:image\/bmp|image\/gif|image\/jpeg|image\/png|image\/x\-xwindowdump|image\/x\-portable\-bitmap)$/i; 

        ImgReader.onload = function (Event) {
            if (!ImagePre) {
                var newPreview = document.getElementById("imagePreview");
                ImagePre = new Image();
                ImagePre.style.width = "200px";
                ImagePre.style.height = "140px";
                newPreview.appendChild(ImagePre);
            }
            ImagePre.src = Event.target.result;
            
        };

        return function () {
           
            var img = document.getElementById("image").files;
           
            if (!fileType.test(img[0].type)) { 
               alert("이미지 파일을 업로드 하세요"); 
               return; 
            }
            
            ImgReader.readAsDataURL(img[0]);
        }

    }
            
            document.getElementById("imagePreview").src = document.getElementById("image").value;

      
})();

</script>
      <%@ include file="../../layouts/subheader.jspf" %>
<div class="container">

      <div class="mt-3" style="width:460px; margin:0 auto; padding-top:10px">
            <div style="margin-bottom:10px; text-align:center; font-weight:bold; font-size:27px; ">신규 매장등록</font></div>
            <form method="POST" enctype="multipart/form-data" onSubmit="return chkForm(this);">
                <div class="title" >분류</div><br>
                <select class="form-control form-control-sm" name="cate_id" style="font-size:18px;">
              <option value="1">숙박</option>
              <option value="2">놀거리</option>
              <option value="3">음식점</option>
             </select>
                <br><br>
                <div class="title">상호명</div>
                     <input type="text" name="store_name" style="font-size:18px;" value="" class="form-control" placeholder="상호명"/><br><br>
                <div class="title">매장사진</div>
                <div id="imagePreview"></div>
                <div>
                     <input type="file" class="btn btn-default" id="image"  name="photofile" onchange="InputImage();"><br><br>
                </div>
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
         <div class="addrdiv"><input type="hidden" id="sample4_postcode" placeholder="우편번호" style="font-size:18px;" value="">
         <input type="button" class="btn btn-dark" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
         <input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="store_roadaddr" style="font-size:18px;" value="" class="form-control">
         <input type="text" id="sample4_jibunAddress" placeholder="지번주소" name="store_jibunaddr" style="font-size:18px;" value="" class="form-control">
         <input type="text" placeholder="상세주소" name="store_loc"  style="font-size:18px;" value="" class="form-control">
         <span id="guide" style="color:#999"></span>
         </div><br>

                
               <div class="title">영업 시작 시간</div>
               <input type="time" name="store_starttime" style="font-size:18px;" value="" class="form-control"/>
                <div class="title">영업 종료 시간</div>
               <input type="time" name="store_endtime" style="font-size:18px;" value="" class="form-control"/>
               <div class="title">전화번호</div>
               <input type="text" id="pnum" name="store_pnum1" style="font-size:18px;"> -
                <input type="text" id="pnum" name="store_pnum2" style="font-size:18px;"/> -
                <input type="text" id="pnum" name="store_pnum3" style="font-size:18px;"/>
                <div class="title">홈페이지 주소</div>
               <input type="text" name="store_hp" style="font-size:20px;" value="" class="form-control"/>
                <br><br>
               <div class="title">정보</div>
               <textarea name="store_content" style="font-size:18px; padding:10px; width:100%; height:200px; border:#222222 solid 1px; margin-top:15px;" placeholder="내용을 자유롭게 써주세요." class="form-control"></textarea>
               <br>
               <button type="submit" class="btn btn-dark" style=width:100%;>매장 등록</button>
            </form>

      </div>
      <div style="width:460px; margin:0 auto; padding-top:30px; padding-bottom:30px;">
   </div>
   </div>
</body>
</html>