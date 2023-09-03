<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>회원가입화면</title>
<style type="text/css">
@import url("style.css");
</style>
</head>
<body style="font-size: 25px">
	<form action="authentication.jsp" method="post">
		<table border="1"
			style="align-items: center; margin-left: auto; margin-right: auto;">

			<input type="hidden" name="action" value="register">

			<caption>회원 가입</caption>
			<tr>
				<td>ID(닉네임)</td>
				<td><input type="text" name="id" required="requiered"></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input type="password" name="pw" required="requiered"></td>
			</tr>

		</table>
		<input type="submit" value="중복확인 및 가입" style="font-size: 20px"> <input type="button"
			value="돌아가기" onclick="location='login.jsp'" style="font-size: 20px"><br>
		<p></p>

	</form>
</body>
</html>