<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 현재 내 페이지 위치 정보 가져와 네비바 버튼에 활성 상태 표시
	String current_page = (String)session.getAttribute("current_page");
%>
    
<%-- 직원 전용 네비바: 내 정보 보기 | 프로필 | 출퇴근 | 스케줄 | 급여관리 --%>
<ul class="mb-5 nav justify-content-center nav-pills nav-fill">
  <li class="nav-item">
    <a class="nav-link ${current_page eq 'staffMain' ? 'active' : ''}" href="${pageContext.request.contextPath}/companyone/staff/staffMain.jsp">내 정보 보기</a>
  </li>
  <li class="nav-item">
    <a class="nav-link ${current_page eq 'profile' ? 'active' : ''}" href="${pageContext.request.contextPath}/companyone/staff/info/profile.jsp">프로필 관리</a>
  </li>
  <li class="nav-item">
    <a class="nav-link ${current_page eq 'log' ? 'active' : ''}" href="${pageContext.request.contextPath }/companyone/staff/log/log.jsp">출퇴근</a>
  </li>
  <li class="nav-item">
    <a class="nav-link ${current_page eq 'schedule' ? 'active' : ''}" href="${pageContext.request.contextPath}/companyone/staff/schedule/schedule.jsp">스케줄</a>
  </li>
  <li class="nav-item">
    <a class="nav-link ${current_page eq 'salary' ? 'active' : ''}" href="${pageContext.request.contextPath }/companyone/staff/salary/salary.jsp">급여 계산</a>
  </li>
</ul>