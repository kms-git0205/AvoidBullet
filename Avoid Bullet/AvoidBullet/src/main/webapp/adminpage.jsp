<%@page import="com.kms.dao.UserDao"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.kms.model.User"%>
<%@page import="java.util.List"%>


<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>관리자페이지</title>
<style type="text/css">
@import url("style.css");
</style>
</head>
<body>

	<%
		String tmp = (String)request.getAttribute("userlist");
		String[] list = tmp.split("\n");		
	%>
	<table border="1"
		style="align-items: center; margin-left: auto; margin-right: auto; font-size: 15px">
		<caption style="font-size: 30px">&lt;Users&gt;</caption>

		<tr>
			<th>ID(닉네임)</th>
			<th>Password</th>
			<th>최근 로그인 시간</th>
			<th>전체 순위</th>
			<th>최고점수</th>
			<th>-</th>
		</tr>


		<%
			
			if(!tmp.isEmpty()){
				for(int i=0; i<list.length; i++){ 
					String[] elements = list[i].split(" "); 
			%>
		<tr>
			<td id=<%=elements[0]%>><%=elements[0]%></td>
			<td><%=elements[1]%></td>
			<td><%=elements[2] + " " + elements[3]%></td>
			<td><%=elements[4]%></td>
			<td><%=elements[5]%></td>
			<td><input type="button" id=<%=elements[0]%> value="사용자 삭제"
				onclick="deleteuser(this)"></td>
		</tr>

		<%
				}
			}
			%>

	</table>
	<%if(tmp.isEmpty()){ %>
	<p>현재 등록된 사용자가 없습니다.</p>
	<% } %>

	<br>
	<input type="button" value="돌아가기"
		onclick="location='authentication.jsp?action=start'" style="font-size: 25px">


	<script>
		function deleteuser(obj){
			
			var res = confirm("정말로 삭제하시겠습니까?(" + obj.id + ")");
			//document.write(res);
			
			if(res){		
				location.href="UserController?userid="+ obj.id +"&password=12171588&state=deletion";
				alert("삭제가 완료되었습니다.("+obj.id+")");
			}
			else{
				
			}	
		}
	
	</script>

</body>
</html>