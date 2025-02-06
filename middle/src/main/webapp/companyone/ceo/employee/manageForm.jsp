<%@page import="test.dao.Com1Dao"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@page import="java.util.List"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	//현재 페이지 위치를 세션 영역에 저장 (관리자 전용 네비바에 활성 상태 표시 위함)
	session.setAttribute("current_page", "manageForm");


	//로그인 상태 표시 : 세션 영역에서 접속 계정 정보 가져오기
	String comname = (String)session.getAttribute("comname");
	String ename = (String)session.getAttribute("ename");

	
	// 보여줘야 할 목록 조건을 파라미터로 받기
	String condition = (String)request.getParameter("condition");
	if(condition == null) condition = "all";// default 값은 all	

	
	// DB 에서 정보 추출
	Com1EmpDao empDao = Com1EmpDao.getInstance();
	if(condition.equals("all")){			
		List<Com1EmpDto> empList = empDao.getList();
	} else if(condition.equals("admin")){	
		List<Com1EmpDto> adminList = empDao.getListAdmin();
	} else if(condition.equals("staff")){	
		List<Com1EmpDto> staffList = empDao.getListStaff();
	} else {				
		int storenum = Integer.parseInt(request.getParameter("storenum"));
		List<Com1EmpDto> storeEmpList = empDao.getListByStoreNum(storenum); 
	}

	
	// 몇 호점 리스트 정보 가져오기
	List<Integer> storeList = Com1Dao.getInstance().getStoreNumList();
	
	System.out.println("condition: " + condition);
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
	<!-- 페이지 로딩에 필요한 자원 -->
	<jsp:include page="/include/resource.jsp"></jsp:include>
	<!-- 공통 네비바 -->
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<!-- 현재 접속 상태 표시 -->
	<div class="container">
		<p><%=comname %>의  <%=ename %>님 접속 중</p>
	</div>
	
	
	<!-- 본문 -->
	<div class="contents text-center mt-3 mx-auto" style="width:900px;">
		<!-- 관리자 페이지 전용 네비바: 관리자 페이지 이동을 쉽게 하기 위함 -->
		<jsp:include page="/include/ceoNav.jsp"></jsp:include>
		<h4>근무 직원 현황</h4>
		
		<!-- 조회 조건 -->
		<ul class="nav nav-tabs">
		  	<li class="nav-item">
		  		<a class="nav-link" aria-current="page" href="manageForm.jsp?condition=all">전체 직원</a>
		  	</li>
		  	<li class="nav-item">
		  		<a class="nav-link" aria-current="page" href="manageForm.jsp?condition=admin">점장</a>
		  	</li>
		  	<li class="nav-item">
		  		<a class="nav-link" aria-current="page" href="manageForm.jsp?condition=staff">직원</a>
		  	</li>
		  	
		  	<li class="nav-item dropdown">
		  		<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">몇 호점 별 직원</a>
		  		<ul class="dropdown-menu">
		  			<%-- <c:forEach var="num" items="${storeList}"> 이건 왜 안되여??--%>
		  			<c:forEach var="num" items="<%=storeList %>">
		  				<li><a class="dropdown-item" href="manageForm.jsp?condition=store&storenum=${num}">${num}</a></li>
		  			</c:forEach>
			    </ul>
		  	</li>
		</ul>
		
		
		<!-- 조회 결과 -->
		<div class="tab-content" id="myTabContent">
			<table>
				<thead>
					<tr>호점</tr>
					<tr>사원 번호</tr>
					<tr>이름</tr>
					<tr>직급</tr>
					<tr>전화번호</tr>
					<tr>월급</tr>
					<tr>이메일</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test='${condition eq "all"}'>
							<script>console.log("여긴 들어옴")</script>
		  					<c:forEach var="tmp" items="${empList}">
		  						<td>${tmp.storeNum }</td>
		  						<td>${tmp.empNo }</td>
		  						<td>${tmp.eName }</td>
		  						<td>${tmp.role }</td>
		  						<td>${tmp.eCall }</td>
		  						<td>${tmp.sal }</td>
		  						<td>${tmp.email }</td>
		  					</c:forEach>
		  				</c:when>
		  				<c:when test='${condition eq "admin"}'>
		  					<c:forEach var="tmp" items="${adminList}"></c:forEach>
		  				</c:when>
		  				<c:when test='${condition eq "staff"}'>
		  					<c:forEach var="tmp" items="${staffList}"></c:forEach> 
		  				</c:when>
		  				<c:otherwise>
		  					
		  				</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			
		</div>
	</div>
					
		
		
		

	<!-- 푸터 -->
	<div class="position-fixed bottom-0 w-100">
  	<jsp:include page="/include/footer.jsp" />
  	</div>
</body>
</html>