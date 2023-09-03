<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Opening</title>
<style type="text/css">
@import url("style.css");
</style>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
%>

	<!-- 전체 페이지를 나타냄-> 이 페이지를 통해 게임 전체 흐름 진행 -->

	<iframe src="authentication.jsp?action=start" width="700" height="700"
		scrolling="no"> </iframe>

</body>
</html>