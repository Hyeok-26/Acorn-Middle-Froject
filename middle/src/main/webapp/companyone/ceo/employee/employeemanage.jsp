<%@page import="test.dao.Com1Dao"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@page import="java.util.List"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//현재 페이지 위치를 세션 영역에 저장 (관리자 전용 네비바에 활성 상태 표시 위함)
	session.setAttribute("current_page", "emolyeeManageForm");


	//로그인 상태 표시 : 세션 영역에서 접속 계정 정보 가져오기
	String comname = (String)session.getAttribute("comname");
	String ename = (String)session.getAttribute("ename");

	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 목록 페이지</title>
<style>
	/* div{ border:1px solid red; } */
</style>
</head>
<body>
	<%-- 페이지 로딩에 필요한 자원 --%>
	<jsp:include page="/include/resource.jsp"></jsp:include>
	<%-- 공통 네비바 --%>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<%-- 현재 접속 상태 표시 --%>
	<div class="container">
		<p><%=comname %>의  <%=ename %>님 접속 중</p>
	</div>
	
	
	<%-- 본문 --%>
	<div class="contents text-center mt-3 mx-auto" style="width:900px;">
		<%-- 관리자 페이지 전용 네비바: 관리자 페이지 이동을 쉽게 하기 위함 --%>
		<jsp:include page="/include/ceoNav.jsp"></jsp:include>
		<h4>근무 직원 현황</h4>
		
		<div>
			<ul class="nav nav-tabs">
			  <li class="nav-item">
			    <a class="nav-link" href="#">전체 직원</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="#">점장</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="#">직원</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="#">호점</a>
			  </li>
			</ul>
		</div>
	</div>
		
		
	
	

	<!-- 푸터 -->
	<div class="position-fixed bottom-0 w-100">
  	<jsp:include page="/include/footer.jsp" />
  	</div>
</body>
</html>