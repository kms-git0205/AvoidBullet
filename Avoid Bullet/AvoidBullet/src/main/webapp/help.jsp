<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>도움말 화면</title>
<style type="text/css">
@import url("style.css");
</style>
</head>
<body style="text-align: left; padding: 30px 50px">
	<p>
		<h1>&lt;도움말&gt;</h1>총알피하기 게임을 구현했습니다.<br>
		
		  회원가입 후, 로그인하여 게임을 진행하면
		됩니다.<br> 
		방향키로 이동하며, 다시하기는 r키입니다. 총알에 캐릭터가 닿으면 게임이 종료됩니다.<br>
		<br> 
		  구현한 기능 : 회원가입, 로그인, 비밀번호 변경, 게임기능, DB연동(Mybatis 이용), 관리자기능,
		명예의 전당(1위 표시)<br> 
		<br>
		   자세한 사항은 보고서에 기술했습니다.
		 <br> - 12171588 김민석 -
	</p><br>
	<input type="button" value="돌아가기" style="font-size: 25px; float: right" 
		onclick="location='authentication.jsp?action=start'">

</body>
</html>