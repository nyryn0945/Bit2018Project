/**
 * storeInfo.js
 */

var map = new naver.maps.Map('map');
naver.maps.Service.geocode({
	address : myaddress
}, function(status, response) {
	if (status !== naver.maps.Service.Status.OK) {
		return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
	}
	var result = response.result;
	// 검색 결과 갯수: result.total
	// 첫번째 결과 결과 주소: result.items[0].address
	// 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
	var myaddr = new naver.maps.Point(result.items[0].point.x,
			result.items[0].point.y);
	map.setCenter(myaddr); // 검색된 좌표로 지도 이동
	// 마커 표시
	var marker = new naver.maps.Marker({
		position : myaddr,
		map : map
	});
});

// 삭제 확인
$('#delete-store').on('click', function(e) {
	e.preventDefault();
	if (confirm('이 매장을 삭제하시겠습니까?')) {
		location.href = $(this).attr('href');
	}
});

// 리뷰 작성
$('#reviewForm').on('submit', function(e) {
	e.preventDefault();
	
	var textarea = $(this).find('textarea');
	var content = textarea.val();
	if (content == '') {
		alert('리뷰를 입력해주세요.');
		textarea.focus();
		return false;
	}
	
	var data = $(this).serialize();
	
	var btn = $(this).find('.btn');
	btn.prop('disabled', true);
	
	$.ajax({
		url: '/night/store/review',
		type: 'POST',
		data: data,
		dataType: 'JSON'
	})
	.done(function(res) {
		var li = $('<li class="list-group-item"></li>');
		li.attr('data-review-id', res.review_id);
		li.append(
			$('<div class="review-header mb-2"></div>').append(
				$('<span class="font-weight-bold"></span>').text(res.mb_username),
				$('<time class="ml-2 text-muted small"></time>').text(res.review_date),
				$('<i class="fas fa-times btn-review-delete float-right pl-3"></i>')
			),
			$('<div class="review-content"></div>').append(res.review_content.replace(/(?:\r\n|\r|\n)/g, '<br>'))
		);
		
		if ($('#reviewList').length > 0) {
			li.appendTo($('#reviewList'));
		}
		else {
			var list = $('<ul id="reviewList" class="list-group m-3 mx-lg-0"></ul>');
			list.append(li);
			list.insertAfter($('#review'));
		}
		textarea.val('');
	})
	.always(function() {
		btn.prop('disabled', false);
	});
});

$('#reviewList').on('click', '.btn-review-delete', function(e) {
	if (!confirm('이 리뷰를 삭제하시겠습니까?'))
		return false;
	
	var li = $(this).closest('li');
	var reviewId = li.data('reviewId');
	$.ajax({
		url: '/night/store/reviewDelete/' + reviewId,
		type: 'POST',
		dataType: 'JSON'
	})
	.done(function(res) {
		if (!res.success) {
			alert(res.msg);
			return;
		}
		
		li.remove();
		if ($('#reviewList li').length == 0) {
			$('#reviewList').remove();
		}
	});
});