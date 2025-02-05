<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진세님 출퇴근 페이지</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
<style>
	.container2 {
        max-width: 800px;
        margin: 40px auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        border: 1px solid black;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .time-container{
    	text-align: center;
    }
    .clock h1{
    	font-size:70px;
    	font-weight:bold;
    	padding: 30px 0 60px 0;
    }
	.button-container {
        display: flex;
        justify-content: space-around;
        margin-top: 30px;
    }
    .btn {
        padding: 20px 30px; 
        font-size: 30px;
        width: 200px;
    }
    .btn:disabled {
        background-color: #ccc; 
        cursor: not-allowed; 
    }
    
</style>
</head>
<body>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<div class="container2">
		<h1>출/퇴근</h1>
		<div class="time-container">
			<div class="clock">
        		<h1>00:00:00</h1>
   			</div>
			<div class="btn-container d-flex justify-content-around">
				<button id="startBtn" class="btn btn-primary">출근</button>
				<button id="endBtn" class="btn btn-primary">퇴근</button>
			</div>
		</div>
	</div>
	<jsp:include page="/include/footer.jsp" />
	<script>
		const clock = document.querySelector(".clock");
		const clockTitle = clock.querySelector("h1");
		const startBtn = document.getElementById("startBtn");
		const endBtn = document.getElementById("endBtn");
		//시간 함수
		function Time(){
		    const date = new Date();
		    const hour = date.getHours(); //시
		    const minute = date.getMinutes(); //분
		    const second = date.getSeconds(); //초
		    clockTitle.innerText = `\${hour}:\${minute}:\${second}`;
		    console.log(`\${hour}:\${minute}:\${second}`);
		}
		//시계 표현
		function show(){
		    Time();
		    setInterval(Time,1000);
		    console.log();
		}
		show();
		//근무 시작
		startBtn.addEventListener("click", function() {
		    startBtn.disabled = true; 
		    endBtn.disabled = false; 
		    alert("출근!!");
		});
		//근무 끝
		endBtn.addEventListener("click", function() {
		    startBtn.disabled = false; 
		    endBtn.disabled = true; 
		    alert("퇴근!!");
		});

		// 초기 상태 설정: 퇴근 버튼 비활성화
		endBtn.disabled = true;
	</script>
</body>
</html>