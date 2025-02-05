<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 현재 내 페이지 위치 정보 가져와 네비바 버튼에 활성 상태 표시
	String current_page = (String)session.getAttribute("current_page");
%>
    
<%-- 관리자 전용 네비바: 내 정보 보기 | 가입 승인 | 직원 현황 | 매출 관리 | 퇴사 관리 --%>
<ul class="nav justify-content-center nav-pills nav-fill">
  <li class="nav-item">
    <a class="nav-link ${current_page eq 'myinfo' ? 'active' : ''}" href="${pageContext.request.contextPath}/companyone/ceo/myinfo_ceo.jsp">내 정보 보기</a>
  </li>
  <li class="nav-item">
    <a class="nav-link ${current_page eq 'accept-form' ? 'active' : ''}" href="${pageContext.request.contextPath }/companyone/ceo/accept/acceptForm.jsp">가입 승인</a>
  </li>
  <li class="nav-item">
    <a class="nav-link ${current_page eq 'employee-magange' ? 'active' : ''}" href="${pageContext.request.contextPath}/companyone/ceo/employee/employeemanage.jsp">직원 현황</a>
  </li>
  <li class="nav-item">
    <a class="nav-link ${current_page eq 'yet' ? 'active' : ''}" href="#">매출 관리</a>
  </li>
  <li class="nav-item">
    <a class="nav-link ${current_page eq 'quit-form' ? 'active' : ''}" href="${pageContext.request.contextPath }/companyone/ceo/quit/quitForm.jsp">퇴사 관리</a>
  </li>
</ul>