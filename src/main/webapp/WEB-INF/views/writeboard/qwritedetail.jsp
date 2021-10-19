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
@import url('https://fonts.googleapis.com/css2?family=Gaegu&display=swap');

 #qwritedetail{
      align:center;
      margin:0 auto;
      width:1400px;
    }
li input{
	border:none;
	outline: none;
}
#hr{
	border: 1px solid green;
}
#replyarea input{
	border-bottom: 1px solid silver;
}
.btn1{
	background-color: white;
}
.btn1:hover{
	color: green;
	text-decoration: underline;
}
 ul li,label{
	font-family: 'Gaegu', cursive;
	font-size: 22px;
	font-weight: bold;
}
hr{
	color: green;
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
}
.replytext{
	border: 1px solid silver;
}
</style>
<body>
<div id="qwritedetail">
<br><br><br><br><br><br>
<div class="modal">
	<div class="modal_content" title="클릭하면 닫기!.">
		<img class="modalimg" src="">
	</div>
</div>
<ul>
	<li>
		<div>
		<label>작성자</label>
		<span> : ${list.user_id }</span>
		</div>
		<label>카테고리</label>
		<span> : ${list.category}</span>
		<hr id="hr">
	</li>
	<li>
		<label>제목</label>
		<input type="text" id="title" value="${list.title }" readonly>
		<hr id="hr">
	</li>
	<li>
		<c:if test="${list2!=null  }">
		<div class="preview">
		<label>첨부 사진</label><span style="font-size: 15px;"> (사진 클릭시 확대해서 볼 수 있습니다.)</span>
			<c:forEach var="item" items="${list2 }">
				<div class="preview-box">
					<img class="moimg" src="${pageContext.request.contextPath }/resources/img/${item.real_name}" width="100px" height="100px">
					<p>${item.real_name}</p>
				</div>
			</c:forEach>
		</div>
		</c:if>
	<div class="clear"></div>
	</li>
	<li>
		<label>내용</label><br><hr id="hr">
		<textarea rows="20" cols="100"  readonly style="resize: none;">${list.content }</textarea>
	</li>
	<li>
	<div class="clear"></div><hr id="hr">
		<c:if test="${id == list.user_id }">
		<input type="button" class="btn1" id="modibtn" value="수정" onclick="location.href='${pageContext.request.contextPath }/qwritemodify/${list.qnano}'">
		<input type="button" class="btn1" id="delbtn" value="삭제" onclick="del()">
		</c:if>
		<input type="button" class="btn1" id="qlist" value="목록" onclick="location.href='${pageContext.request.contextPath }/qnalist'">
	<br><br><br><br>
	</li>
	<c:if test="${not empty list3}">
	<li>
		<label>답변</label>
		<hr id="hr">
		<c:forEach var="item" items="${list3 }">
			<li value="${item.replyno }">
				<div class="replychild_btn" style="margin-left:${10*item.dept}px; display: flex; justify-content: space-between; margin-bottom:5px">
				<div>
				<c:if test="${item.dept==1 }">
					<img  src="${pageContext.request.contextPath }/resources/img/화살표.jfif" width="40px" height="25px" style="margin-left:${20*item.dept}px;"> 
				</c:if>
				<span>${item.user_id }</span>&ensp;
				</div>
				<span style="flex-grow: 1;"> >> ${item.reply_content }</span>
				<input type="text" name="reply_writedate" value="${item.reply_writedate }" readonly>
					<c:if test="${id eq item.user_id && item.dept==0}">
						<a href="${pageContext.request.contextPath }/qreplydelete/${item.replyno}/${list.qnano}" style="color: red; font-size: 13px; margin-top: 7px;">삭제</a>
					</c:if>
					<c:if test="${id eq item.user_id && item.dept==1}">
						<a href="${pageContext.request.contextPath }/qreplydelete2/${item.replyno}/${list.qnano}" style="color: red; font-size: 13px; margin-top: 7px;">삭제</a>
					</c:if>
				</div>
				<input type="hidden" value="${item.replyno }" name="replyno" class="replyno">
				<input type="hidden" value="${item.dept }" name="dept" class="dept">
				<input type="hidden" value="${item.reorder }" name="reorder" class="reorder">
				<input type="hidden" value="${item.reparent }" name="reparent" class="reparent">
			</li>
		</c:forEach>
	</li>
	</c:if>
	<li>
	<c:if test="${id ne null}">
		<div><br>	
			<div id="replydiv">
			<hr id="hr">
				<label>답변 쓰기</label>
				<form action="${pageContext.request.contextPath }/qreplyresult" method="post">
				<input type="hidden" name="user_id" value="${id }">
				<input type="hidden" id="qnano" name="qnano" value="${list.qnano }">
				<textarea class="replytext" rows="4" cols="90" id="reply_content" name="reply_content" placeholder="댓글을 입력하세요." required style="resize: none;"></textarea>
				<input type="submit" value="등록" style="margin-bottom:5px;" class="btn1">
				</form><br><br><br><br>
			</div>
		</div>
	</c:if>
	</li>
</ul>	
</div>
<script>
function del() {
    if (!confirm("정말 삭제 하시겠습니까?")) {
        
    } else {
        alert("삭제하셨습니다.");
        location.href="${pageContext.request.contextPath }/qwritedelete/${list.qnano}";
    }
}
//대댓글
$(function () {
	$(".replychild_btn").on("click",function(){
		
		let $this=$(this);
		let no=$this.parent().val();
		let data1={qnano:$("#qnano").val()
					,replyno:no
					};
		let id="${id}";
		console.log(no);
 	$.ajax({
			type:'post'
			,url:"${pageContext.request.contextPath }/qreplychild"
			,dataType:'json'
			,data: JSON.stringify(data1)
			,contentType:"application/json;charset=utf-8"
			,success:function(data)
			{
				console.log("성공");
				let p="";
				p+="<form method='post' class='replyform' action='${pageContext.request.contextPath }/qreplychildinsert'>";
	 			p+="<input type='hidden' name='user_id' value='"+id+"'>";
				p+="<input type='hidden' name='qnano' value='"+${list.qnano }+"'>";
				p+="<textarea rows='4' cols='90' name='reply_content' placeholder='댓글을 입력하세요.' style='margin-left:25px; resize: none;'></textarea>";
				p+="<input type='hidden' name='reorder' value='"+data.reorder+"'>";
				p+="<input type='hidden' name='reparent' value='"+no+"'>";
				p+="<input type='submit' value='댓글달기'>";
				p+="</form>";
				
				$('.replyform').remove();
				$this.parent().append(p);
			},error:function(err){
				console.log("에러");
			}
		})  
	})
})
</script>
</div>
</body>
</html>