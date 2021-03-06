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
#qwritemodi{
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
<div id="qwritemodi">
<br><br><br><br><br><br>
<form method="post" action="${pageContext.request.contextPath }/qwritemodifyresult" enctype="multipart/form-data">
<ul>
	<li>
		<label for="category">카테고리</label>
		<select name="category">
			<option >카테고리를 설정해주세요</option>
			<option value="질문" >질문</option>
			<option value="신고" >신고</option>
		</select>
		<hr class="hr1">
	</li>
	<li>
		<input type="hidden" name="qnano" id="qnano" value="${list.qnano }">
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
				<label>미리보기</label>
				<div id="preview" class="filecontent"></div>

			</div>
			<div class="clear"></div><hr class="hr1">
		</li>
	<li>
		<textarea rows="20" cols="100" name="content" style="resize: none;">${list.content }</textarea>
	</li>
	<li>
		<hr class="hr1">
		<input type="submit" value="등록" class="btn1">
		<input type="button" value="취소" class="btn1" onclick="location.href='${pageContext.request.contextPath }/qwritedetail/${list.qnano}'">
	</li>
</ul><br><br><br><br>	
</form>

<script src="${pageContext.request.contextPath}/resources/js/writeboard.js"></script>
</div>
</body>
</html>