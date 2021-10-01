<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/writeboard.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=vjjh2gafg5"></script>
<script>
//경매 기능
$(function () {
	$('#deal_btn').on('click',function(){
		var before=Number($("#ndeal_price").val());
		var after=Number($("#deal_price").val());
		if(after<before){
			alert("입력한 가격이 현재 입찰가 보다 낮습니다");
		}
		   let data1={tradeno:$("#tradeno").val(),deal_price:$("#deal_price").val()};
		 $.ajax({
			type:"post"
			,url:'${pageContext.request.contextPath }/deal'
		    ,dataType:"json"
			,data: JSON.stringify(data1)
			,contentType:"application/json;charset=utf-8"
			,success:function(data)
			{
				alert("입찰 성공!");
				$('#ndeal_price').val(data);
				$('#deal_price').val(""); //초기화
			},error:function(err){
				console.log(err);
			} 
		})
	})
})

</script>
<body>
<br><br><br><br>
<ul>
	<li>
		<label>카테고리</label>
		<input type="text" id="detailcategory1" value="${list.category1 }" readonly>
		<input type="text" id="detailcategory2" value="${list.category2 }" readonly>
	</li>
	<li>	
		<input type="hidden" name="tradeno" id="tradeno" value="${list.tradeno }">
		<label>제목</label>
		<input type="text" id="title" value="${list.title }" readonly>
	</li>
	<li>
		<label>현재 입찰가격</label>
		<input type="text" id="ndeal_price" value="${price }" readonly>
		<label>입찰 희망가격</label>
		<input type="text" id="deal_price" name="deal_price" >
		<button id="deal_btn" >입찰하기</button>
	</li>
	<li>
		<label>첨부 사진</label>
		<c:if test="${list2!=null }">
		<div class="preview">
			<c:forEach var="item" items="${list2 }">
				<div class="preview-box">
					<img src="${pageContext.request.contextPath }/resources/img/${item.real_name}" width="100px" height="100px">
				</div>
			</c:forEach>
		</div>
		</c:if>
	<div class="clear"></div>
	</li>
	<li>
		<textarea rows="19" cols="68" class="left" readonly>${list.content }</textarea>
		<div class="right">
		<label>장소 설정</label>
		<p id="map" style="width: 500px; height: 400px;"></p>
		</div>
	</li>
	<li>
	<div class="clear"></div>
		<input type="button" id="modibtn" value="수정" onclick="location.href='${pageContext.request.contextPath }/twritemodify/${list.tradeno}'">
		<input type="button" id="delbtn" value="삭제" onclick="location.href='${pageContext.request.contextPath }/twritedelete/${list.tradeno}'">
	</li>
</ul>	
<script src="${pageContext.request.contextPath}/resources/js/writeboard.js"></script>
<script>
var mapOptions = {
		center : new naver.maps.LatLng(${list.map_x},${list.map_y}),
		zoom : 18
	};
var map = new naver.maps.Map('map', mapOptions);

var markerList = [];
var marker = new naver.maps.Marker({
    position: new naver.maps.LatLng(${list.map_x}, ${list.map_y}),
    map: map
});

</script>
</body>
</html>