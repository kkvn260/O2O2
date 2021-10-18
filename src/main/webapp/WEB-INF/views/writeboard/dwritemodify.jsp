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
<style>
.btn1{
	background-color: white;
	border: none;
}
.btn1:hover{
	color: green;
	text-decoration: underline;
}
  #dwritemodi{
      align:center;
      margin:0 auto;
      width:1400px;
    }
ul li,label{
	font-family: 'Gaegu', cursive;
	font-size: 22px;
	font-weight: bold;
}
option,select {
	font-size: 22px;
	font-family: 'Gaegu', cursive;
}
input {
	font-family: 'Gaegu', cursive;
	font-size: 22px;
	border: 0;
}
input:focus, textarea:focus{
	outline: none;
}
textarea{
	border: none;
}
.hr1{
	color: green;
	border: 1px solid green;
}
</style>
<body>
<div id="dwritemodi">
<br><br><br><br><br><br>
<form method="post" action="${pageContext.request.contextPath }/dwritemodifyresult" enctype="multipart/form-data">
<ul>
	<li>
		<label for="category">카테고리</label>
		<input type="text" name="map_x" id="map_x" required style="color: white; float: right;" >
		<input type="text" name="map_y" id="map_y" required style="color: white; float: right;" >
		<select name="category1" id="category1"></select>
		<select name="category2" id="category2"></select>
		<hr class="hr1">
	</li>
	<li>
		<input type="hidden" name="chatno" id="chatno" value="${list.chatno }">
		<label>제목</label>
		<input type="text" id="title" name="title" value="${list.title }" size="100">
		<hr class="hr1">
	</li>
	<li>
		<li>
			<div class="filebody">
				<c:if test="${list2!=null }">
			<label>수정 전 첨부사진</label>
			<div>
				<div class="preview">
					<c:forEach var="item" items="${list2 }">
						<div class="preview-box">
							<img src="${pageContext.request.contextPath }/resources/img/${item.real_name}" width="100px" height="100px">
							<p>${item.real_name}</p>
						</div>
					</c:forEach>
				</div>
			</div>
				</c:if>
				<div class="clear"></div><hr class="hr1">
				<div id="attach">
					<label class="upload" for="filedata">사진첨부</label>
					<input id="filedata" type="file" name="filedata" style="display: none" multiple accept="image/*"/>
				</div>
				<div id="preview" class="filecontent"></div>
			</div>
			<div class="clear"></div>
		</li>
	<li>
		<label>내용</label><br><hr class="hr1">
		<textarea rows="15" cols="65" class="left" name="content" style="resize: none;">${list.content }</textarea>
		<div class="right">
		<label><img alt="지도" src="${pageContext.request.contextPath }/resources/img/지도아이콘.png" width="25px" height="25px">장소 설정</label>
		<p id="map" style="width: 650px; height: 470px;"></p>
		</div>
	</li>
	<li>
		<div class="clear"></div>
	</li>
	<li>
		<hr class="hr1">
		<input type="submit" value="등록" class="btn1">
		<input type="button" value="취소" class="btn1" onclick="location.href='${pageContext.request.contextPath }/dwritedetail/${list.chatno}'">
	</li>
</ul><br><br><br><br>

</form>

<script src="${pageContext.request.contextPath}/resources/js/writeboard.js"></script>
<script>
	  
	    //naver Map
		var mapOptions = {
			center : new naver.maps.LatLng(${list.map_x}, ${list.map_y}),
			zoom : 18
		};
		
		var map = new naver.maps.Map('map', mapOptions);
		var markerList = [];
        var marker = new naver.maps.Marker({
            position: new naver.maps.LatLng(${list.map_x}, ${list.map_y}),
            map: map
        });
        
        markerList.push(marker);
		
	    naver.maps.Event.addListener(map, 'click', function(e) {
	    for (var i=0, ii=markerList.length; i<ii; i++) {
            markerList[i].setMap(null);
        }
	        markerList = [];
	        var marker = new naver.maps.Marker({
	            position: e.coord,
	            map: map
	        });
	        
	        markerList.push(marker);
 	        document.getElementById("map_x").value = e.coord.lat();
	        document.getElementById("map_y").value = e.coord.lng(); 
	        
	    });

	  	
	</script>
	</div>
</body>
</html>