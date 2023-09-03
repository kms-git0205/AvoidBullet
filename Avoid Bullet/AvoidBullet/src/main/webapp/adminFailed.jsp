<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>관리자 로그인 화면</title>
<style type="text/css">
@import url("style.css");
</style>
</head>
<body style="font-size: 20px">
	<form action="authentication.jsp" method="post">

		<input type="hidden" name="action" value="admin">
		<table border="1"
			style="align-items: center; margin-left: auto; margin-right: auto;">
			<caption>Admin Login</caption>
			<tr>
				<td>ID</td>
				<td><input type="text" name="id" required="required"></td>
			</tr>
			<tr>
				<td>PW</td>
				<td><input type="password" name="pw"></td>
			</tr>


		</table>

		<input type="submit" value="로그인"> <input type="button"
			value="돌아가기" onclick="location='authentication.jsp?action=start'">
	</form>
	<p id="msg" style="color: red">관리자 로그인 실패</p>



</body>
</html>