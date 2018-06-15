<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="../../layouts/header.jspf" %>
<style>
	.container {
		width: 1150px;
	}
	.row{
		width: 100%;  
    } 
    .img{
    	width: 20%;
        float: left;
    }
    .title{
		float: left;
		margin-left: 50px;
	}
    .times{
    	width: 76%;
    	float: left;
    }
    .jibunaddr{
    	width: 76%;
    	float: left;
    }
    .ul1{
    	border-bottom:1px solid #dddddd;
    	margin-bottom: 10px;
    }
    
    .listmore{
    	width: 100%;
/*     	background-image: url(https://s3-ap-northeast-1.amazonaws.com/dcicons/dicons_20160930/m/new/images/search/ic-search-more-list@2x.png);
	    background-position: 81% 10px;
	    background-size: 17px 24px;	 */
    }
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
						<img src="/night/uploadfile/storephoto/lastnight.png" width="100%;" style="padding-bottom: 10px;">
					</div>
				</div>
				<div class="swiper-pagination"></div>
			</div>
		</div>
      <form id="Storesearch" class="form-inline mb-2">
	            <input type="text" name="searchStore" class="form-control" id="searchStore" style="width: 50%;">
	            <input type="hidden" name="startNum" class="form-control" id="startNum" style="width: 50%;" value="0">
	            &nbsp;&nbsp;
            	<button type="submit" class="ml-sm-2 btn btn-dark" onclick="countclick();">검색</button>     
      </form>
      <div class="div">
      <!-- <div>
      	<h3 style="background-color: #dddddd; padding: 5px 10px;">검색결과</h3>
      </div> -->
      	<div id="ajaxDiv" class="row" style="margin: 0px;">
	  		
	  	</div>
	  </div>				
      <button type="submit" id="btn" class="ml-sm-2 btn btn-dark listmore d-none" style="padding: 5px;">더보기</button>
   </div>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
var startNum = 0;
var count = 0;

getData();
   
function countclick(){
   count++;
   console.log(count);
   $("#btn").removeClass("d-none");
   
if(count > 1) 
   startNum = 0;   
   $('#btn').unbind('click');
   $('#btn').click(function(){
      $.ajax({
         url:'searchStore',
         type:'GET',
         dataType:'JSON',
         data:{
            searchStore: $('#searchStore').val(),
            startNum: startNum+=10
         },
         success:function(res) {   
        	 var $ajaxDiv = $('#ajaxDiv');
        	 $.each(res, function(i, row) {
         		var $div = $('<div class="col-sm-6 ul1" style="padding: 10px;">').append(	               		   				
         			$('<div class="img"><img src="${pageContext.request.contextPath}/uploadfile/storephoto/'+row.store_photo+'" onError="noImage(this)" style="width:100px; height:80px;">'),           			
         			$('</div>'),	   				
          	   		$('<div class="title"><a href="storeInfo?store_id='+row.store_id+'&addressName='+row.store_jibunaddr+'"style="color:black; font-weight:bold">'+row.store_name+'</a><br>'+row.store_pnum1+'-'+row.store_pnum2+"-"+row.store_pnum3+'<br>'+row.store_jibunaddr),
          	   		$('</div>'),
          	   		$('</div>'));
	             $div.appendTo($ajaxDiv);
       		});
        	
         }
      })
   });
}

function getData() {
   $('#Storesearch').submit(function(e) {
      e.preventDefault();
      var $this = $(this);
      console.log($this.serialize());
      console.log(startNum);
      // 아약스         
      	$.ajax({
        	url:'searchStore',
            type:'GET',
            dataType:'JSON',
            data:$this.serialize(),
            success:function(res) {
               var $ajaxDiv = $('#ajaxDiv');
            	$ajaxDiv.html('');
            	   $.each(res, function(i, row) {
            		var $div = $('<div class="col-sm-6 ul1" style="padding: 10px;">').append(	               		   				
            			$('<div class="img"><img src="${pageContext.request.contextPath}/uploadfile/storephoto/'+row.store_photo+'" onError="noImage(this)" style="width:100px; height:80px;">'),           			
            			$('</div>'),	   				
             	   		$('<div class="title"><a href="storeInfo?store_id='+row.store_id+'&addressName='+row.store_jibunaddr+'"style="color:black; font-weight:bold">'+row.store_name+'</a><div>'+row.store_jibunaddr+'</div><div>'
             	   		+row.store_pnum1+'-'+row.store_pnum2+"-"+row.store_pnum3+'</div>'),
             	   		$('</div>'),
             	   		$('</div>'));
	             $div.appendTo($ajaxDiv);
            });
         }
      })
   });
}


</script>
<%@ include file="../../layouts/subfooter.jspf" %>
<%@ include file="../../layouts/footer.jspf" %>