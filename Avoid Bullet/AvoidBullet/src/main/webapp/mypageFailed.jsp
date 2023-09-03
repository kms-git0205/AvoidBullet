<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.kms.dao.UserDao"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.kms.model.User"%>
<%@page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Page</title>
<style type="text/css">
@import url("style.css");
</style>
</head>
<body style="text-align: left; font-size: 20px; padding : 30px 50px">
	<h1>My Page</h1>

	플레이어 : ${user.userid}
	<br> 현재순위 : ${user.rank_u}
	<br> 최고점수: ${user.score}
	<br> 최근접속: "${user.lastlogin}"
	<br><br>

	<input type="button" value="Game Start" style="font-size: 25px"
		onclick="location='authentication.jsp?id=${user.userid}&pw=${user.password}&action=gameplay'"> &nbsp;&nbsp;
	<input type="button" value="Logout" style="font-size: 25px"
		onclick="location='authentication.jsp?action=start'">
	<br><br>

	<form id="modify" 
		action="authentication.jsp?id=${user.userid}&pw=${user.password}&action=modifyuser"
		method="post">
		<br><br> &lt;비밀번호 변경란&gt;<br> 현재 비밀번호 입력 : <input
			type="password" name="rcvdPw" required="required"><br>
		새로운 비밀번호 입력 : <input type="password" name="newPw" required="required"><br><br>

		<input type="submit" value="비밀번호 변경" onclick="modifyPw();" style="font-size: 20px">

	</form>
	<p id="msg" style="color:red">현재 비밀번호가 틀렸습니다.</p>

	<script>
		function modifyPw() {
			if (document.getElementById("newPw").value == ""
					|| document.getElementById("rcvdPw").value == "")
				return;

			if ("${user.userid}" == (document.getElementById("rcvdPw").value))
				alert("변경완료. 다시 로그인 해주세요.");
			else
				alert("비밀번호가 틀렸습니다.");
		}
	</script>
</body>
</html>