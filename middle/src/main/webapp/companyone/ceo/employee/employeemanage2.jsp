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

	
	
	/* 
	// DB에서 직원, 점장, 관리자 리스트 정보 추출
	Com1EmpDao empDao = Com1EmpDao.getInstance();
	List<Com1EmpDto> employeeList = empDao.getList();	// 전체 목록
	List<Com1EmpDto> adminList = empDao.getListAdmin();	// 점장만 목록
	List<Com1EmpDto> staffList = empDao.getListStaff(); // 직원만 목록
	
	// DB에서 지점 리스트 정보 추출
	Com1Dao com1Dao = Com1Dao.getInstance();
	List<Integer> storeNumbers = com1Dao.getStoreNumList(); // 지점 목록

	// 요청에서 넘어온 지점 번호가 있는지 확인
	String storenumParam = request.getParameter("storenum");
    int storenum = -1;  
    List<Com1EmpDto> storeEmpList = null;

    // 요청에서 넘어온 지점번호가 있다면
    if (storenumParam != null && !storenumParam.isEmpty()) {
    	// 넘어온 지점 번호 사용
        storenum = Integer.parseInt(storenumParam);
    	// DB 그 지점번호에 속한 직원 정보 리스트 추출
        storeEmpList = empDao.getListByStoreNum(storenum); 
    } */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 목록 페이지</title>
<style>
	div{ border:1px solid red; }
</style>
</head>
<body>
	<%-- 페이지 로딩에 필요한 자원 --%>
	<jsp:include page="/include/resource.jsp"></jsp:include>
	<%-- 공통 네비바 --%>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	

	<div class="container">
		<%-- 관리자 페이지 전용 네비바: 관리자 페이지 이동을 쉽게 하기 위함 --%>
		<jsp:include page="/include/ceoNav.jsp"></jsp:include>
	
		<%-- 현재 접속 상태 표시 --%>
		<div class="text-end">
			<p><%=comname %>의  <%=ename %>님 접속 중... </p>
		</div>
		
		<%-- 정보 표시 --%>
		<div class="contents mb-5 mx-auto text-center" >
			<h3>근무 직원 현황</h3>
			<div style="height:400px; margin:10px;">
			
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
	</div>
		
	
	

	

	<%@ include file="/include/footer.jsp"%>

	<script>

	</script>
</body>
</html>