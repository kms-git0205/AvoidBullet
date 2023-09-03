<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>게임시작화면</title>
<style type="text/css">
@import url("style.css");
</style>
</head>
<body>

	<h1>&lt;총알피하기&gt;</h1>
	<br>
	<br>
	<h2>12171588 김민석</h2>
	<p style="font-size: 30px">
		<br> 명예의 전당 - 1위 : ${userid} / ${score}점<br> <br> 
	</p>
	<input type="button" value="게임 시작" onclick="location='login.jsp'" style="font-size: 30px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="도움말" onclick="location='help.jsp'" style="font-size: 30px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="관리자" onclick="location='adminlogin.jsp'" style="font-size: 30px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


	<canvas id="myCanvas" width="500" height="300"></canvas>
	<script>

//오프닝화면 디자인

var canvas = document.getElementById('myCanvas');
var context = canvas.getContext('2d');

var dx = 5;
var dy = 5;

var x= Math.round(Math.random() * (canvas.width-20))+20;
var y= Math.round(Math.random() * (canvas.height-20))+20;


function draw() {
 	
 	
 	context.clearRect(x-25, y-25, 50, 50);
 	
 	context.beginPath();
    context.fillStyle = "#"+Math.round(Math.random() * 0xffffff).toString(16);
    context.arc(x, y, 20, 0, Math.PI * 2, true);
    context.closePath();
    context.fill();
    if (x < (0 + 20) || x > (canvas.width - 20))
        dx = -dx;
    if (y < (0 + 20) || y > (canvas.height - 20))
        dy = -dy;
    x += dx;
    y += dy;
}

var xt=Math.round(Math.random() * (canvas.width-20))+20;
var yt=Math.round(Math.random() * (canvas.height-20))+20;

var dxt = 7;
var dyt = 7;
function draw2() {
 
 	context.clearRect(xt-27, yt-27, 54, 54);
    context.beginPath();
    context.fillStyle = "#"+Math.round(Math.random() * 0xffffff).toString(16);
    context.arc(xt, yt, 20, 0, Math.PI * 2, true);
    context.closePath();
    context.fill();
    if (xt < (0 + 20) || xt > (canvas.width - 20))
        dxt = -dxt;
    if (yt < (0 + 20) || yt > (canvas.height - 20))
        dyt = -dyt;
    xt += dxt;
    yt += dyt;
}
setInterval(function(){draw(); draw2();} , 10);

</script>
</body>
</html>