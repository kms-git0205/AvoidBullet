<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="com.kms.dao.UserDao"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.kms.model.User"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="imagetoolbar" content="no" />
<title>게임</title>

<style type="text/css">
@import url("style.css");
</style>

</head>
<body style="font-size: 20px; text-align: left; padding : 0px 50px" >

	<h1>&lt;Playing&gt;</h1>
	<b style="align-items : right"> 현재 점수: <b id="score">0</b></b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
	<b>최고 점수 : ${user.score}</b>
	<div id="msg" style="float: left">
	<canvas id="myCanvas" width="500" height="300" tabindex="0"></canvas><br><br>
		<b style="font-size: 30px">다시하기 : R</b><br><br> <input type="button" value="Mypage" style="font-size: 25px"
			onclick="location='authentication.jsp?id=${user.userid}&pw=${user.password}&action=login'"> &nbsp;
		<input type="button" value="Logout" style="font-size: 25px"
			onclick="location='authentication.jsp?action=start'"><br>
	</div>

	<div style="float: right">
	플레이어 : ${user.userid}
	<br> 현재 순위 : ${user.rank_u}
	<br> Last Login: ${user.lastlogin}
	</div>
	
	
	<script>

var canvas=document.getElementById('myCanvas');
var context=canvas.getContext('2d');


context.lineWidth=1;	//선 넓이	
context.strokeStyle='rgba(255,255,255,0.5)';	//선 색깔 지정 - R G B  투명도
	

//spaceship [x, y, w, h, colors, speed]	
var spaceship=[
canvas.width/2-6,
canvas.height/2-4,
12,
8,
[
	[0,8,'#B2B2B2'],	//x, y, 색깔
	[0,8,'#FFF'],
	[3,2,'#7C7C7C'],
	[3,2,'#575757'],
	[1,6,'#7C7C7C'],
	[1,6,'#B2B2B2'],
	[1,6,'#FFF'],
	[1,6,'#FFF'],
	[3,2,'#FFF'],
	[3,2,'#7C7C7C'],
	[0,8,'#B2B2B2'],
	[0,8,'#FFF'],
],
2
];

//bullets [x, y, speed, moveangle, max x, max y]
//x, y, 속도, 이동방향(x, y), 최대x, 최대y
var bullets=50;	//총알 개수
var bullet=[];


//stars [color, x, y, speed] - 배경에 별들
var stars=100;	
var star=[];
for(var i=0; i<stars; i++){
	star.push([	//x, y, 속도값 push
		canvas.width*Math.random(),
		canvas.height*Math.random(),
		10*Math.random()
	]);
	var color=Math.round(100+(star[i][2]*10));
	star[i].unshift('rgba('+color+','+color+','+color+',1)');	//앞에 색깔 추가
}

//keyboard
var key={
	left : false,
	up : false,
	right : false,
	down : false
}


for(var i=0; i<bullets; i++){
	addbullet();
}


function checkGameover(){	//게임오버인 경우 종료
	if(gameover){
		clearInterval(playing);
		clearInterval(bulletPlus);
	}
}
//add bullet
function addbullet(){
	var i=bullet.length;
	bullet.push([	//x, y, 속도 값 넣기
		(canvas.width/2)+Math.cos(i*(360/bullets))*(canvas.width/1.5),
		(canvas.height/2)+Math.sin(i*(360/bullets))*(canvas.height/1.5),
		0.5*Math.random()+1.0
	]);

	//이동방향, 최대x, 최대y값 넣기
	bullet[i].push(Math.atan2((canvas.width/2)-30+60*Math.random()-bullet[i][0],(canvas.height/2)-30+60*Math.random()-bullet[i][1]));
	bullet[i].push((bullet[i][0]>0)? 0 : canvas.width);
	bullet[i].push((bullet[i][1]>0)? 0 : canvas.height);
}


//총알 그리기
function drawbullets(){
	context.fillStyle='#FF7';


	for(var i=0; i<bullets; i++){
		


		if(	//총알과 비행기가 닿는 경우
			context.isPointInPath(bullet[i][0],bullet[i][1]) ||
			context.isPointInPath(bullet[i][0]+2,bullet[i][1]) ||
			context.isPointInPath(bullet[i][0],bullet[i][1]+2) ||
			context.isPointInPath(bullet[i][0]+2,bullet[i][1]+2)
		){	//죽음
			gameover=true;
			ScoreSet();	//점수 세팅 등 게임오버 이후의 행동
		}
		
		//총알 한 픽셀 이동
		bullet[i][0]=bullet[i][0]+(bullet[i][2]*Math.sin(bullet[i][3]));
		bullet[i][1]=bullet[i][1]+(bullet[i][2]*Math.cos(bullet[i][3]));
		bullet[i][0]=parseInt(bullet[i][0]*100)/100;
		bullet[i][1]=parseInt(bullet[i][1]*100)/100;
		

		//예외처리
		if(
			(!bullet[i][4] && bullet[i][0]<-10) || (bullet[i][4] && bullet[i][0]>canvas.width+10) ||
			(!bullet[i][5] && bullet[i][1]<-10) || (bullet[i][5] && bullet[i][1]>canvas.height+10)
		){
			random=bullets*Math.random();
			bullet[i][0]=(canvas.width/2)+Math.cos(random*(360/bullets))*(canvas.width);
			bullet[i][1]=(canvas.height/2)+Math.sin(random*(360/bullets))*(canvas.height);
			bullet[i][3]=Math.atan2(spaceship[0]-30+(60*Math.random())-bullet[i][0],spaceship[1]-30+(60*Math.random())-bullet[i][1]);
			bullet[i][4]=(bullet[i][0]>0)? 0 : canvas.width;
			bullet[i][5]=(bullet[i][1]>0)? 0 : canvas.height;
		}


		context.fillRect(bullet[i][0],bullet[i][1],2,2);
	}
}

//키보드 이벤트처리(비행기 이동)
document.documentElement.onkeydown=function(e){
	var keycode=e.keyCode;
	e.preventDefault();
	if(keycode==37) key.left=true;
	if(keycode==38) key.up=true;
	if(keycode==39) key.right=true;
	if(keycode==40) key.down=true;
	
	if(keycode==82) window.location.reload(false); //r 누르면 재시작
}
document.documentElement.onkeyup=function(e){
	var keycode=e.keyCode;
	e.preventDefault();
	if(keycode==37) key.left=false;
	if(keycode==38) key.up=false;
	if(keycode==39) key.right=false;
	if(keycode==40) key.down=false;
	
}

function drawspaceship(){	//우주선 그리기
	
	//키가 눌릴 때마다 그 방향으로 speed만큼 가면서 구현
	if(key.left) spaceship[0]=spaceship[0]-spaceship[5];
	if(key.up) spaceship[1]=spaceship[1]-spaceship[5];
	if(key.right) spaceship[0]=spaceship[0]+spaceship[5];
	if(key.down) spaceship[1]=spaceship[1]+spaceship[5];
	
	//예외처리
	if(spaceship[0]<0) spaceship[0]=0;
	else if(spaceship[0]+spaceship[2]>canvas.width) spaceship[0]=canvas.width-spaceship[2];
	if(spaceship[1]<0) spaceship[1]=0;
	else if(spaceship[1]+spaceship[3]>canvas.height) spaceship[1]=canvas.height-spaceship[3];


	for(var i=0; i<spaceship[2]; i++){
		context.fillStyle=spaceship[4][i][2];
		context.fillRect(spaceship[0]+i,spaceship[1]+spaceship[4][i][0],1,spaceship[4][i][1]);
	}

	//그리기 진행
	context.beginPath();
	context.rect(spaceship[0],spaceship[1],spaceship[2],spaceship[3]);
	context.closePath();

}

function drawstars(){	//별 그리기
	
	for(var i=0; i<stars; i++){
		
		if(star[i][2]>canvas.height){
			star[i][1]=canvas.width*Math.random();
			star[i][2]=0;
		}
		context.fillStyle=star[i][0];	//색깔 채우기
		context.fillRect(star[i][1],star[i][2],1,1);	//사각형 그리기
		star[i][2]=star[i][2]+star[i][3];
	}
}
function drawBackground(){
 	context.fillStyle = "black";	//색 지정
	context.fillRect(0, 0, canvas.width, canvas.height);	//사각형 영역 색칠
}


document.getElementById("msg").focus();
function Go(){ 
	location.reload();
	document.getElementById("msg").focus();
}

function Scoring(){	//점수 상승
	score+=11;
	document.getElementById("score").innerHTML = score;
}

var gameover = false;	//게임오버 확인
var score = 0;	//게임 점수

var playing = setInterval(function(){checkGameover(); drawBackground(); drawstars(); drawspaceship();drawbullets(); Scoring()}, 10);
//게임오버여부 확인 -> 배경 칠하기 -> 별 그리기 -> 비행기 그리기 -> 총알 그리기 -> 점수 상승 반복 / drawBullets()에서 게임오버 탐지
var bulletPlus = setInterval(function(){bullets+=1; addbullet();}, 1000);
//주기적으로 총알 수 늘리기

function ScoreSet(){	//게임 오버 이후에 할 행동들
	//점수가 해당 유저의 최고기록이면, 알림을 띄우면서
	//유저의 최고점수를 수정하기
	if(score > ${user.score}){
	
		checkGameover();	//게임 종료
		alert( score + "점 -> 신기록입니다!");	
		var path = "authentication.jsp?id=" + "${user.userid}" + "&pw="+"${user.password}"
					+ "&score=" + score + "&action=gameover";
		
		location.href = path;	//페이지 이동
	}
}

</script>

</body>
</html>