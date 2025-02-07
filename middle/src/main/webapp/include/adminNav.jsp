<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 현재 내 페이지 위치 정보 가져와 네비바 버튼에 활성 상태 표시
	String current_page = (String)session.getAttribute("current_page");

session.setAttribute("current_page", "manageForm");
%>

<%-- 점장 전용 네비바: 홈 | 개인정보조회 | 매출관리 | 사원승인 | 직원관리 | 직원스케줄 | 직원월급 --%>
<ul class="mb-5 nav justify-content-center nav-pills nav-fill">
  <li class="nav-item">
    <a class="nav-link" href="${pageContext.request.contextPath}/companyone/admin/adminMain.jsp">홈</a>
  </li>
  
  <li class="nav-item">
    <a class="nav-link ${current_page eq 'infoview' ? 'active' : ''}" href="${pageContext.request.contextPath}/companyone/admin/info/view.jsp">개인정보조회</a>
  </li>
  <li class="nav-item">
    <a class="nav-link ${current_page eq 'saleview' ? 'active' : ''}" href="${pageContext.request.contextPath }/companyone/admin/sale/view.jsp">매출관리</a>
  </li>
  <li class="nav-item">
    <a class="nav-link ${current_page eq 'acceptStaff' ? 'active' : ''}" href="${pageContext.request.contextPath}/companyone/admin/accept/acceptStaff.jsp">사원승인</a>
  </li>
  <li class="nav-item">
    <a class="nav-link ${current_page eq 'staffstatusview' ? 'active' : ''}" href="${pageContext.request.contextPath}/companyone/admin/staffstatus/view.jsp">직원관리</a>
  </li>
  <li class="nav-item">
    <a class="nav-link ${current_page eq 'staffscheduleview' ? 'active' : ''}" href="${pageContext.request.contextPath }/companyone/admin/staffschedule/view.jsp">직원스케줄</a>
  </li>
  <li class="nav-item">
    <a class="nav-link ${current_page eq 'staffsalaryview' ? 'active' : ''}" href="${pageContext.request.contextPath }/companyone/admin/staffsalary/view.jsp">직원월급</a>
  </li>
</ul>