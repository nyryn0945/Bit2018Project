/**
 * storeRegForm.js
 */

var InputImage = (function loadImageFile() {
	if (window.FileReader) {
		var ImagePre;
		var ImgReader = new window.FileReader();
		var fileType = /^(?:image\/bmp|image\/gif|image\/jpeg|image\/png|image\/x\-xwindowdump|image\/x\-portable\-bitmap)$/i;

		ImgReader.onload = function (Event) {
			if (!ImagePre) {
				var newPreview = document.getElementById('imagePreview');
				newPreview.innerHTML = '';
				ImagePre = new Image();
				ImagePre.style.width = '300px';
				ImagePre.classList.add('img-thumbnail');
				newPreview.appendChild(ImagePre);
				newPreview.classList.add('mt-3');
			}
			ImagePre.src = Event.target.result;
		};

		return function () {
			var img = document.getElementById('image').files;
			if (!fileType.test(img[0].type)) {
				alert('이미지 파일을 업로드 하세요');
				return;
			}console.log(img);
			ImgReader.readAsDataURL(img[0]);
		};
	}
	document.getElementById('imagePreview').src = document.getElementById('image').value;
})();

//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
function execDaumPostcode() {
	new daum.Postcode({
		oncomplete: function (data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
			var extraRoadAddr = ''; // 도로명 조합형 주소 변수

			// 법정동명이 있을 경우 추가한다. (법정리는 제외)
			// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
				extraRoadAddr += data.bname;
			}
			// 건물명이 있고, 공동주택일 경우 추가한다.
			if (data.buildingName !== '' && data.apartment === 'Y') {
				extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			}
			// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			if (extraRoadAddr !== '') {
				extraRoadAddr = ' (' + extraRoadAddr + ')';
			}
			// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
			if (fullRoadAddr !== '') {
				fullRoadAddr += extraRoadAddr;
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
			document.getElementById('roadAddress').value = fullRoadAddr;
			document.getElementById('jibunAddress').value = data.jibunAddress;

			// 커서를 상세주소 필드로 이동한다.
			document.getElementById('address2').focus();
		}
	}).open();
}

function chkForm(obj) {
	if (!obj.store_name.value) {
		alert('상호명을 입력해 주세요.');
		obj.store_name.focus();
		return false;
	}
	if (!obj.store_roadaddr.value) {
		alert('도로명주소를 입력해 주세요.');
		obj.store_roadaddr.focus();
		return false;
	}
	if (!obj.store_jibunaddr.value) {
		alert('지번주소를 입력해 주세요.');
		obj.store_jibunaddr.focus();
		return false;
	}
	if (!obj.store_loc.value) {
		alert('상세주소를 입력해 주세요.');
		obj.store_loc.focus();
		return false;
	}
	if (!obj.store_starttime.value) {
		alert('영업 시작 시간을 입력해 주세요.');
		obj.store_starttime.focus();
		return false;
	}
	if (!obj.store_endtime.value) {
		alert('영업 종료 시간을 입력해 주세요.');
		obj.store_endtime.focus();
		return false;
	}
	if (!confirm('매장을 등록 하시겠습니까?')) {
		return false;
	}
}