<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../include/include.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="js/jquery.form.js"></script>
<script type="text/javascript">
function goodsCartAdd(goodsNum){
	$.ajax({
		type : "post",
		url : "<c:url value='/cart/goodsCartAdd'/>",
		dataType : "text",
		data : {"goodsNum":goodsNum}, //"goodsNum="+goodsNum
		success : function(result){
			if (result.trim() == "1") {
				if (confirm("계속 쇼핑하시려면 '아니오'를 누르시오")) {
					location.href="<c:url value='/cart/goodsCartList'/>";			
				}
			}else{
				alert("장바구니에 담기지 않았습니다.\n 다시 시도해주세요.")
			}
		},		
		error : function(){
			alert('에러가 나왔다');
			return;
		},
		
	});
}
$(function(){
	$("#wishBtn").click(function(){
		$.ajax({
			type : "post",
			url : "../cart/goodsWishAdd",
			data : {"goodsNum" : "${goods.goodsNum}"},
			dataType : "text",
			success : function(result){
				if (result.trim() == "1") {
					$("#wishBtn").attr("src","../images/right_arrow.png")
					alert("관심상품에 등록되었습니다.")
				}else if(result.trim() !="1"){
					$("#wishBtn").attr("src", "../images/left_arrow.png");
					alert("관심상품에 삭제되었습니다.")
					
				}
			},
			error : function(){
				alert('서버 오류입니다. 잠시후 다시 해주세요.')
			}
		});
	});
});


</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table align="center" width="600" border="1">
	<tr bgcolor="orange">
		<td align="right">조회수 : ${goods.readCount }
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			관심상품<img src="../images/left_arrow.png" id="wishBtn"/>
		<a href="javascript:goodsCartAdd(${goods.goodsNum });">장바구니 담기</a>
	</tr>
</table>

<table align="center" width="600"  >
	<tr>
		<td rowspan="4">
		<c:forTokens items="${goods.goodsImage }" delims="`" var="img" begin="0" end="0">
		<img src="../goodsView/upload/${img }" width="50" height="50"/>
		</c:forTokens>
		</td>
		<td>상품명 : ${goods.goodsName } </td>
	</tr>
	<tr>
	 <td>가격: ${goods.goodsPrice }</td>
	</tr>
	</table>
	<table align="center" width="600">
	
	<tr>
	 <td>상품 설명: ${fn:replace(goods.goodsContent,cn,br) }<br/>
	 <div align="center">
	 <c:forTokens items="${goods.goodsImage }" delims="`" var="img" begin="1" end="10">
		<img src="../goodsView/upload/${img }" width="100" height="100"/>
		</c:forTokens>
	 </div>
	 </td>
	</tr>
    <tr><td colspan="2" align="center">
    		<a href="goodsList">목록보기</a> |
    		<a href=
    		"../cart/goodsDelete?goodsNum=${goods.goodsNum }">
    		상품 삭제</a> |
    		<a href="goodsModify?goodsNum=${goods.goodsNum }">상품 수정</a>
    	</td>
    </tr>
</table>
</body>
</html>