<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>�� �б�</title>
<style>
.iw_inner {
	padding: 10px
}

.iw_inner h3 {
	font-size: 18px;
	padding-bottom: 7px
}

.header {
	color: white;
	background-color: #00CED1;
	height: 150px;
}
.col-6 {
	float: left;
}
</style>
<link rel="stylesheet" href="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/autocomplete.css?2018031306" type="text/css">
</head>
<body>
	<input type="hidden" name="address" class="form-control" id="address"
		size="20" value="0">
	<script type="text/javascript"
		src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=ZmmkCPbYEQrryHW1Ck0T&submodules=geocoder"></script>
	<div id="map" style="width: 100%; height: 400px;"></div>
	<script>
		var map = new naver.maps.Map('map');
		var myaddress = '${addressName}'; //�ּҰ� �޾ƿ��� ex) ������� 53
		//var myaddress = '��絿 263-11'; //�ּҰ� �޾ƿ��� ex) ������� 53

		// ���θ� �ּҳ� ���� �ּҸ� ���� (�ǹ��� �Ұ�!!!!)
		naver.maps.Service.geocode({
			address : myaddress
		}, function(status, response) {
			if (status !== naver.maps.Service.Status.OK) {
				return alert(myaddress + '�� �˻� ����� ���ų� ��Ÿ ��Ʈ��ũ ����');
			}
			var result = response.result;
			// �˻� ��� ����: result.total
			// ù��° ��� ��� �ּ�: result.items[0].address
			// ù��° �˻� ��� ��ǥ: result.items[0].point.y, result.items[0].point.x
			var myaddr = new naver.maps.Point(result.items[0].point.x,
					result.items[0].point.y);
			map.setCenter(myaddr); // �˻��� ��ǥ�� ���� �̵�
			// ��Ŀ ǥ��
			var marker = new naver.maps.Marker({
				position : myaddr,
				map : map
			});
		});
	</script>
	
	<div class="header">
		<span>${resultstore.store_name}</span>
	</div>	
	
		<hr>
	
	<div>
	<div>
		<h3><img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-profile-facilities@2x.png">${resultstore.cate_name}</h3>
		<h3><img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-profile-address@2x.png">${resultstore.store_loc}</h3>
		<h3><img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-profile-call@2x.png">${resultstore.store_pnum1}-${resultstore.store_pnum2}-${resultstore.store_pnum3}</h3>
	</div>
	<div class="col-6">
		<h1><img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-profile-time@2x.png">���� �ð�</h1>
		<h3>�������۽ð�:&nbsp;&nbsp;&nbsp;${resultstore.store_starttime}</h3>
		<h3>��������ð�:&nbsp;&nbsp;&nbsp;${resultstore.store_endtime}</h3>
	</div>
	<div class="col-6">
		<h1><img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-profile-time@2x.png">�޴� ����</h1>
		<h3>�������۽ð�:&nbsp;&nbsp;&nbsp;${resultstore.store_starttime}</h3>
		<h3>��������ð�:&nbsp;&nbsp;&nbsp;${resultstore.store_endtime}</h3>
	</div>
	<div>
		<h3><img src="https://dfzrjox9sv97l.cloudfront.net/dicons_20160930/img/profile/main/icon-profile-tag@2x.png">${resultstore.store_hp}</h3>
		<h3>${resultstore.store_content}</h3>
		<table>
		<tr>
			<td><fmt:formatDate value="${resultstore.store_date}"
					type="date" pattern="YYYY/MM/dd HH:mm" /></td>
					<a href="storeSearchList">��Ϻ���</a> 
		<a href="reply.do?parentId=${article.id}&page=${param.page}">�亯����</a> 
		<a href="storeUpdate?store_id=${store.store_id}">�����ϱ�</a> 
		<a href="storeDelete?store_id=${store.store_id}">�����ϱ�</a>
		</tr>
	</table>
	</div>	
	</div>
	
	
</body>
</html>