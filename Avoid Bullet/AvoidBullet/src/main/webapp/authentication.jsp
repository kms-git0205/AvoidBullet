<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style type="text/css">
    @import url("style.css");
</style>
</head>
<body>

<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");	//아이디, 패스워드를 id, pw로 전송받음
	String pw = request.getParameter("pw");	
	String state = request.getParameter("action");	//현재의 상태(로그인, 회원가입 등)
	
	//점수 -> gameover 시에만 전달
	String additional = "";	//get에 추가적으로 전달할 파라미터
	if(state.equals("gameover")){
		String score = request.getParameter("score");		
		additional += "&score="+score;
	}
	
		
	if(state.equals("modifyuser")){	//사용자 정보 변경 시
		
		String received_pw = request.getParameter("rcvdPw");		
		String new_pw = request.getParameter("newPw");		
		
		additional += "&rcvdPw="+received_pw+"&newPw="+new_pw;
	}
		
	
	//추가파라미터 여기에 포함됨
	request.setAttribute("ADDITIONAL",additional);   
	
		
	request.setAttribute("ID",id);   //Attribute 에 호출명 ID 로 저장 
	request.setAttribute("PW",pw);   //Attribute 에 호출명 ID 로 저장 
	request.setAttribute("STATE",state);   //Attribute 에 호출명 ID 로 저장 
	//${ADDITIONAL}
%>

<jsp:forward page="UserController?userid=${ID}&password=${PW}&state=${STATE}${ADDITIONAL}"></jsp:forward>

</body>
</html>