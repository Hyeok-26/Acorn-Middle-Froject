<%-- 안전빵용 페이지 --%>
<%@page import="test.dao.Com1WaitDao"%>
<%@page import="test.dto.Com1WaitDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<%
	//현재 페이지 위치를 세션 영역에 저장 (관리자 전용 네비바에 활성 상태 표시 위함)
	session.setAttribute("current_page", "acceptForm");

	// 로그인 상태 표시 : 세션 영역에서 접속 계정 정보 가져오기
	String comname = (String)session.getAttribute("comname");
	String ename = (String)session.getAttribute("ename");
  
	
	// 로딩 데이터
	Com1WaitDto dto = new Com1WaitDto();
	// DB 에서 대기자 목록 가져오기
	List<Com1WaitDto> list_admin =  Com1WaitDao.getInstance().getListAdmin();
	
	
	
	
	String empInsertMessage = request.getParameter("empInsertMessage");
	String waitDeleteMessage = request.getParameter("waitDeleteMessage");
    if (empInsertMessage != null || waitDeleteMessage != null) {
%>
    <script>
        <% if (empInsertMessage != null) { %>
            alert('<%= empInsertMessage %>');
        <% } %>
        <% if (waitDeleteMessage != null) { %>
            alert('<%= waitDeleteMessage %>');
        <% } %>
    </script>
<% } %>

<html>
<head>
<meta charset="UTF-8">
<title>/ceo/accept-form.jsp</title>
<style>
	/* div{ border:1px solid red; } */
</style>
</head>
<body>
	<%-- 페이지 로딩에 필요한 자원 --%>
	<jsp:include page="/include/resource.jsp"></jsp:include>
	
	<%-- 관리자 페이지 전용 네비바 --%>
	<jsp:include page="/include/ceoNav.jsp"></jsp:include>

	<%-- 현재 접속 상태 표시 --%>
	<div class="container">
	<p><%=comname %>의  <%=ename %>님 접속 중</p>
	</div>
	
	
	<%-- 본문 --%>
	<div class="contents text-center mt-3 mx-auto" style="width:900px;">
		<h4>회원가입 대기자 명단</h4>
		
		<div style="height:400px; margin:10px;">
			<table class="table table-striped ">
				<thead class="table-dark">
					<tr>
						<th>이름</th>
						<th>지점</th>
						<th>직책</th>
						<th>상세보기</th>
						<th>승인</th>
						<th>거절</th>
					</tr>
				</thead>
				<tbody>
					
					<c:choose>
						<%-- 데이터가 없는 경우 --%>
						<c:when test="<%=list_admin.isEmpty() %>">
							</tbody>
							</table>
							<div class=" justify-content-center align-items-center vh-100">
							  <div class="p-3 bg-light">점장의 가입 요청 정보가 없습니다!</div>
							</div>
						</c:when>
						<%-- 데이터가 있는 경우 --%>
						<c:otherwise>
							<c:forEach var="item" items="<%=list_admin %>">
								<tr>
									<td>${item.eName }</td>
									<td>${item.storeNum }</td>
									<td>${item.role }</td>
									<td>상세보기</td>
									<td><a href="acceptAdmin.jsp?empno=${item.empNo}" class="btn btn-success btn-sm">승인</a></td>
									<td><a href="deleteAdmin.jsp?empno=${item.empNo}" class="btn btn-success btn-sm">거절</a></td>
								</tr>
							</c:forEach>
							</tbody>
							</table>
						</c:otherwise>
					</c:choose>
		</div>
		
		<%-- 페이징 --%>
		<nav>
		</nav>
		
	</div>
	
	
	<!-- 푸터 -->
	<div class="position-fixed bottom-0 w-100">
  	<jsp:include page="/include/footer.jsp" />
  	</div>
	
</body>
</html>