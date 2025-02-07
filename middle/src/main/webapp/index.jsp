<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<%
    String message = request.getParameter("message");
    if ("success".equals(message)) {
%>
    <script>
        alert("성공! 메인페이지로 이동합니다!");
        window.location.href = "index.jsp";
    </script>
<%
    }
%>

<head>
    <meta charset="UTF-8"> <!-- UTF-8 인코딩 설정 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프랜차이즈 관리 시스템</title>

    <!-- 부트스트랩 CSS 링크 -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f4f6f9;
        }
        header {
            background-color: #2c3e50;
            color: #fff;
        }
        footer {
            background-color: #2c3e50;
            color: #fff;
        }
        
        /* 부드러운 스크롤 효과 추가 */
        html {
            scroll-behavior: smooth;
        }
    </style>
</head>

<!-- 부트스트랩 컨테이너 -->
<div class="container mt-5">
    <!-- 상호명 및 설명 -->
    <div class="row justify-content-center mb-5">
        <div class="col-md-12 text-center">
            <h1 class="display-4 text-primary">프랜차이즈 관리 시스템</h1>
            <p class="lead">효율적인 관리와 빠른 의사결정을 돕는 시스템입니다.</p>
            <button class="btn btn-warning btn-lg" onclick="changeStoreName()">상호명 변경</button>
            <p id="store-name" class="h4 mt-3">우리매장</p> <!-- 유동적인 상호명 -->
        </div>
    </div>

    <!-- 기능 카드 섹션 -->
    <div class="row">
        <!-- CEO 입장 -->
        <div class="col-md-4 mb-4">
            <div class="card shadow-lg border-primary">
                <div class="card-header bg-primary text-white">
                    <h5 class="card-title"><a href="#section1"><span style="color:white">CEO 입장</span></a></h5>
                </div>
                <div class="card-body">
                    <ul class="list-unstyled">
                        <li><a href="#" class="btn btn-outline-primary btn-block mb-2">지점별 재무 현황</a></li>
                        <li><a href="#" class="btn btn-outline-primary btn-block mb-2">가맹점 관리</a></li>
                        <li><a href="#" class="btn btn-outline-primary btn-block mb-2">손익 상태</a></li>
                        <li><a href="#" class="btn btn-outline-primary btn-block mb-2">회원 가입 승인</a></li>
                        <li><a href="#" class="btn btn-outline-primary btn-block mb-2">퇴사자 관리</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- 점장 입장 -->
        <div class="col-md-4 mb-4">
            <div class="card shadow-lg border-success">
                <div class="card-header bg-success text-white">
                    <h5 class="card-title"><a href="#section2"><span style="color:white">점장 입장</span></a></h5>
                </div>
                <div class="card-body">
                    <ul class="list-unstyled">
                        <li><a href="#" class="btn btn-outline-success btn-block mb-2">매출 관리</a></li>
                        <li><a href="#" class="btn btn-outline-success btn-block mb-2">직원 관리</a></li>
                        <li><a href="#" class="btn btn-outline-success btn-block mb-2">알바 시간표</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- 직원 입장 -->
        <div class="col-md-4 mb-4">
            <div class="card shadow-lg border-warning">
                <div class="card-header bg-warning text-white">
                    <h5 class="card-title"><a href="#section3"><span style="color:white">직원 입장</span></a></h5>
                </div>
                <div class="card-body">
                    <ul class="list-unstyled">
                        <li><a href="#" class="btn btn-outline-warning btn-block mb-2">프로필 관리</a></li>
                        <li><a href="#" class="btn btn-outline-warning btn-block mb-2">스케줄 조회</a></li>
                        <li><a href="#" class="btn btn-outline-warning btn-block mb-2">출/퇴근</a></li>
                        <li><a href="#" class="btn btn-outline-warning btn-block mb-2">급여 계산</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
	
	<!-- 공지사항 섹션 -->
    <div class="row mb-4">
        <div class="col-md-12">
            <div class="card shadow-lg">
                <div class="card-header bg-dark text-white">
                    <h5 class="card-title">공지사항</h5>
                </div>
                <div class="card-body">
                    <ul>
                        <li>2025년 신년 이벤트 안내</li>
                        <li>가맹점 운영 규정 업데이트</li>
                        <li>새로운 가맹점 추가 및 관리 방법</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    
    <!--섹션1 (CEO 페이지 소개)-->
	<div class="card shadow-lg border-primary" style="margin-top: 20px; margin-bottom:30px;">
		<section id="section1" class="bg-light" style="color: black; margin-bottom: 30px; padding: 20px; border-radius: 8px;">
		    <div class="container">
		        <div class="row align-items-center">
		            <div class="col-md-6 text-end">
		                <h3>가입 승인</h3>
		                <p>직원의 싸이트 가입을 허용하세요.<br />
		                	우리 직원만 사용할 수 있습니다.<br />
		                	아무나 사용할 수 없거든요.
		                </p>
		            </div>
		            <div class="col-md-6">
		                <img src="https://media.istockphoto.com/id/2015223595/ko/%EB%B2%A1%ED%84%B0/%EC%A0%9C%ED%95%9C-%EA%B5%AC%EC%97%AD-%EA%B8%88%EC%A7%80-%ED%91%9C%EC%A7%80%ED%8C%90.jpg?s=1024x1024&w=is&k=20&c=3r9AX3UE5PAUzhw3oLiBe37LeaSxWZR3Pwt99oe83O4="
		                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
		            </div>
		        </div>
		    </div>
		    <div class="container">
		        <div class="row align-items-center">
		            <div class="col-md-6">
		                <img src="https://plus.unsplash.com/premium_vector-1682307882545-5bc2546ed322?q=80&w=1480&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
		                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
		            </div>
		            <div class="col-md-6 text-end">
		                <h3>직원 현황 조회</h3>
		                <p>현재 직원 목록을 조회할 수 있습니다.
		                	<br /> 
		                	<li>전체 직원 목록</li>
		                	<li>점장</li>
		                	<li>직원</li>
		                	<li>지점별 직원</li>
		                </p>
		            </div>
		        </div>
		    </div>
		    <div class="container">
		        <div class="row align-items-center">
		            <div class="col-md-6 text-end">
		                <h3>매출 관리</h3>
		                <p>지선 언니 여기다가 설명이용~
		                </p>
		            </div>
		            <div class="col-md-6">
		                <img src="https://media.istockphoto.com/id/1325166649/ko/%EB%B2%A1%ED%84%B0/%EC%82%AC%EC%97%85%EA%B0%80%EB%B3%B5%EA%B5%AC-%EB%B0%8F-%EC%84%B1%EC%9E%A5-%EA%B8%B0%EC%97%85%EC%9D%80-%EC%9C%84%EA%B8%B0%EC%97%90%EC%84%9C-%EC%82%B4%EC%95%84%EB%82%A8%EC%8A%B5%EB%8B%88%EB%8B%A4.jpg?s=1024x1024&w=is&k=20&c=BO9lv1OHdNc6bvUFoq4dqI2oAoI3xXiu0HyWitr_esQ="
		                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
		            </div>
		        </div>
		    </div>
		    <div class="container">
		        <div class="row align-items-center">
		            <div class="col-md-6">
		                <img src="https://media.istockphoto.com/id/528438296/ko/%EB%B2%A1%ED%84%B0/%EC%86%90-%ED%98%88%EC%A0%84-%EC%8A%A4%ED%85%9C%ED%94%84-%EC%9E%88%EB%8A%94-%ED%8C%A8%EC%8A%A4%ED%8F%AC%ED%8A%B8.jpg?s=1024x1024&w=is&k=20&c=x-gzEg5M8wEqlvRUVelRaTVA6oMbPMtX09tLxyGajNA="
		                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
		            </div>
		            <div class="col-md-6 text-end">
		                <h3>퇴사 관리</h3>
		                <p>퇴사 처리를 진행하고 퇴사자 목록을 확인할 수 있습니다.
		                	<br /> 퇴사자 정보를 확인하세요
		                	<br /> 만약의 경우 복귀 시킬 수도 있습니다.
		                </p>
		            </div>
		        </div>
		    </div>
		</section>
	</div>
	
	<!--섹션2 (점장 페이지 소개)-->
	<div class="card shadow-lg border-success" style="margin-top: 20px; margin-bottom:30px">
		<section id="section2" class="bg-light" style="color: black; margin-bottom: 30px; padding: 20px; border-radius: 8px;">
		    <div class="container">
		        <div class="row align-items-center">
		            <div class="col-md-6">
		                <img src="#"
		                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
		            </div>
		            <div class="col-md-6 text-end">
		                <h3>매출 관리</h3>
		                <p>매출 관리 페이지에 대한 설명 
		                	<br /> 이 부분은 텍스트입니다.
		                </p>
		            </div>
		        </div>
		    </div>
		    <div class="container">
		        <div class="row align-items-center">
		        	<div class="col-md-6 text-end">
		                <h3>직원 관리</h3>
		                <p>직원 관리 페이지에 대한 설명 
		                	<br /> 이 부분은 텍스트입니다.
		                </p>
		            </div>
		            <div class="col-md-6">
		                <img src="#"
		                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
		            </div>
		        </div>
		    </div>
		    <div class="container">
		        <div class="row align-items-center">
		            <div class="col-md-6">
		                <img src="#"
		                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
		            </div>
		            <div class="col-md-6 text-end">
		                <h3>알바 시간표</h3>
		                <p>알바 시간표 페이지에 대한 설명 
		                	<br /> 이 부분은 텍스트입니다.
		                </p>
		            </div>
		        </div>
		    </div>
		</section>
	</div>
	
	<!--섹션3 (직원 페이지 소개)-->
	<div class="card shadow-lg border-warning" style="margin-top: 20px; margin-bottom:30px">
		<section id="section3" class="bg-light" style="color: black; margin-bottom: 30px; padding: 20px; border-radius: 8px;">
		    <div class="container">
		        <div class="row align-items-center">
		            <div class="col-md-6 text-end">
		                <h3>프로필 관리</h3>
		                <p>프로필 관리 페이지에 대한 설명
		                	<br /> 이 부분은 텍스트입니다.
		                </p>
		            </div>
		            <div class="col-md-6">
		                <img src="#"
		                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
		            </div>
		        </div>
		    </div>
		    <div class="container">
		        <div class="row align-items-center">
		            <div class="col-md-6">
		                <img src="#"
		                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
		            </div>
		            <div class="col-md-6 text-end">
		                <h3>스케줄 조회</h3>
		                <p>스케줄 조회 페이지에 대한 설명 
		                	<br /> 이 부분은 텍스트입니다.
		                </p>
		            </div>
		        </div>
		    </div>
		    <div class="container">
		        <div class="row align-items-center">
		            <div class="col-md-6 text-end">
		                <h3>출/퇴근</h3>
		                <p>출퇴근 페이지에 대한 설명 
		                	<br /> 이 부분은 텍스트입니다.
		                </p>
		            </div>
		            <div class="col-md-6">
		                <img src="#"
		                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
		            </div>
		        </div>
		    </div>
		    <div class="container">
		        <div class="row align-items-center">
		            <div class="col-md-6">
		                <img src="#"
		                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
		            </div>
		            <div class="col-md-6 text-end">
		                <h3>급여 계산</h3>
		                <p>급여 계산 페이지에 대한 설명 
		                	<br /> 이 부분은 텍스트입니다.
		                </p>
		            </div>
		        </div>
		    </div>
		</section>
	</div>
</div>

<%@ include file="/include/footer.jsp" %>

<!-- 상호명 변경 스크립트 -->
<script>
    function changeStoreName() {
        const newName = prompt("새로운 상호명을 입력하세요:");
        if (newName) {
            document.getElementById("store-name").textContent = newName;
        }
    }
</script>
