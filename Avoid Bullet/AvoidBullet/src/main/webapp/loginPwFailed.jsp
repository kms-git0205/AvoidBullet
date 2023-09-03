<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>로그인화면</title>
<style type="text/css">
@import url("style.css");
</style>
</head>
<body style="font-size: 20px">

	<form action="authentication.jsp" method="post">

		<input type="hidden" name="action" value="login">

		<table border="1"
			style="align-items: center; margin-left: auto; margin-right: auto;login.jsp">
			<caption>Login</caption>
			<tr>
				<td>ID(닉네임)</td>
				<td><input type="text" name="id" required="required"></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input type="password" name="pw" required="required"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="로그인" style="font-size: 20px"> <input
					type="button" value="회원가입" onclick="location='register.jsp'" style="font-size: 20px">
				</td>
			</tr>
		</table>

	</form>
	<br>
	<input type="button" value="돌아가기"
		onclick="location='authentication.jsp?action=start';" style="font-size: 20px">
	<p id="msg" style="color: red">Password 입력이 잘못됨</p>


</body>
</html>