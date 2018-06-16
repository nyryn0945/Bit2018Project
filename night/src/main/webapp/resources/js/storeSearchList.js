var startNum = 0;

$('#store-search').on('submit', function(e) {
	e.preventDefault();
	
	startNum = 0;
	$.ajax({
		url: '/night/store/searchStore',
		type: 'GET',
		dataType: 'JSON',
		data: {
			searchStore: $('#searchStore').val(),
			startNum: startNum
		}
	})
	.done(function(res) {
		var $list = $('#store-list');
		
		// 초기화
		$list.html('');
		$("#btn-view-more").addClass("d-none");
		
		// 결과 없으면 종료
		if (res.length == 0)
			return;
		
		$.each(res, function (i, row) {
			var media = $('<div class="media"></div>');
			media.append(
				$('<div class="img mr-3"><img src="/night/uploadfile/storephoto/' + row.store_photo + '"/></div>'),
				$('<div class="media-body"></div>').append(
					$('<a class="font-weight-bold"></a>').attr('href', '/night/store/storeInfo?store_id=' + row.store_id).text(row.store_name),
					$('<div></div>').text(row.store_jibunaddr),
					$('<div></div>').text(row.store_pnum1 + '-' + row.store_pnum2 + "-" + row.store_pnum3)
				)
			);
			var $li = $('<li class="list-group-item"></li>').append(media);
			$li.appendTo($list);
		});
		$("#btn-view-more").removeClass("d-none");
	});
	return false;
});

$('#btn-view-more').on('click', function() {
	$.ajax({
		url: '/night/store/searchStore',
		type: 'GET',
		dataType: 'JSON',
		data: {
			searchStore: $('#searchStore').val(),
			startNum: startNum += 10
		}
	})
	.done(function(res) {
		var $list = $('#store-list');
		$.each(res, function (i, row) {
			var media = $('<div class="media"></div>');
			media.append(
				$('<div class="img mr-3"><img src="/night/uploadfile/storephoto/' + row.store_photo + '"/></div>'),
				$('<div class="media-body"></div>').append(
					$('<a class="font-weight-bold"></a>').attr('href', '/night/store/storeInfo?store_id=' + row.store_id).text(row.store_name),
					$('<div></div>').text(row.store_jibunaddr),
					$('<div></div>').text(row.store_pnum1 + '-' + row.store_pnum2 + "-" + row.store_pnum3)
				)
			);
			var $li = $('<li class="list-group-item"></li>').append(media);
			$li.appendTo($list);
		});
	});
});