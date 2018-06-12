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
		width: 76%;
		float: left;
	}
    .times{
    	width: 76%;
    	float: left;
    }
    .jibunaddr{
    	width: 76%;
    	float: left;
    }
</style>
<%@ include file="../../layouts/subheader.jspf" %>
   <div class="container mt-3">
      <form id="Storesearch" class="form-inline mb-2">
         <div class="form-group">
            <input type="text" name="searchStore" class="form-control" id="searchStore" size="20">
            <input type="hidden" name="startNum" class="form-control" id="startNum" size="20" value="0">
            <button type="submit" class="ml-sm-2 btn btn-primary" onclick="countclick();">검색</button>
         </div>        
      </form>
      <div class="div">
      	<div id="ajaxDiv" class="row">
	  		
	  	</div>
	  </div>				
      <button type="submit" id="btn" class="ml-sm-2 btn btn-primary">더보기</button>
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
            		 var $div = $('<div>').append(	               		   				
            				$('<div class="img">'),
            				$('<img src="https://d2t7cq5f1ua57i.cloudfront.net/images/r_images/52260/51271/52260_51271_98_0_651_20151220134343864_200x200.jpg" onError="noImage(this)" style="width:200px; height:200px;">'),
             	   			$('</div>'),	   				
                  	   		$('<div class="title">'),
                  	   		$('<a href="storeInfo?store_id='+row.store_id+'&addressName='+row.store_jibunaddr+'"style="color:black; font-weight:bold">'+row.store_name+'</a>'),
     	             	   	$('<div class="times">'+row.store_pnum1+'-'+row.store_pnum2+"-"+row.store_pnum3+'</div>'),
     	     	   			$('<div class="jibunaddr">'+row.store_jibunaddr+'</div>'),
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
            		var $div = $('<div>').append(	               		   				
            			$('<div class="img">'),
            			$('<img src="https://d2t7cq5f1ua57i.cloudfront.net/images/r_images/52260/51271/52260_51271_98_0_651_20151220134343864_200x200.jpg" onError="noImage(this)" style="width:200px; height:200px;">'),
         	   			$('</div>'),	   				
             	   		$('<div class="title">'),
             	   		$('<a href="storeInfo?store_id='+row.store_id+'&addressName='+row.store_jibunaddr+'"style="color:black; font-weight:bold">'+row.store_name+'</a>'),
	             	   	$('<div class="times">'+row.store_pnum1+'-'+row.store_pnum2+"-"+row.store_pnum3+'</div>'),
	     	   			$('<div class="jibunaddr">'+row.store_jibunaddr+'</div>'),
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