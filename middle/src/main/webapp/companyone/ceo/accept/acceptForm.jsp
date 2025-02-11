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
<!-- 페이지 로딩에 필요한 자원 -->
<%-- <jsp:include page="/include/resource.jsp"></jsp:include> --%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
	<!-- 공통 네비바 -->
	<jsp:include page="/include/header.jsp"></jsp:include>
	<%-- 관리자 페이지 전용 네비바 --%>
	<jsp:include page="/include/ceoNav.jsp"></jsp:include>

	
	<div class="main flex-grow-1">  
		<%-- 본문 --%>
		<div class="contents text-center mt-3 mx-auto" style="width:900px;">
			<h4>회원가입 대기자 명단</h4>
			
			<div style="height:500px; margin:10px;">
				<table class="table table-striped ">
					<thead class="table-dark">
						<tr>
							<th>번호</th>
							<th>이름</th>
							<th>지점</th>
							<th>직책</th>
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
										<td>${item.empNo }</td>
										<!-- 이름 -->
										<td><a href="#" id="info" data-bs-toggle="modal" data-bs-target="#showModal">${item.eName }</a></td>
										<!-- 이름을 누르면 나오는 모달창 -->
										<div class="modal fade" id="showModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="showModalLabel" aria-hidden="true">
											<div class="modal-dialog">
											  <div class="modal-content">
											  
											    <div class="modal-header">
											      <h1 class="modal-title fs-5" id="showModalLabel">가입 정보</h1>
											      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
											    </div>
											    
											    <div class="modal-body ">
													<!-- 조회된 데이터 보여줌 -->
												    	<div class="mb-3 row" style="display:none">
												    		<div class="col-3"><label for="empno" class="form-label">사원번호 </label></div>
												    		<div class="col-9"><input type="text" class="form-control" id="empno" name="empno" value="${item.empNo }" readonly></div>
														</div>
														
														<div class="mb-3 row" style="display:flex">
															<div class="col-3"><label for="ename" class="form-label">이름 </label></div>
												    		<div class="col-9"><input type="text" class="form-control" id="ename" name="ename" value="${item.eName }" readonly></div>
														</div>
														
														<div class="mb-3 row">
															<div class="col-3"><label for="store" class="form-label">영업점 </label></div>
												    		<div class="col-9"><input type="text" class="form-control" id="store" name="store" value="${item.storeNum }" readonly></div>
														</div>
														
														<div class="mb-3 row">
															<div class="col-3"><label for="role" class="form-label">역할 </label></div>
												    		<div class="col-9"><input type="text" class="form-control" id="role" name="role" value="${item.role }" readonly></div>
														</div>
														
														<div class="mb-3 row">
															<div class="col-3"><label for="email" class="form-label">이메일 </label></div>
												    		<div class="col-9"><input type="text" class="form-control" id="email" name="email" value="${item.email }" readonly></div>
														</div>
														
														<div class="mb-3 row">
															<div class="col-3"><label for="call" class="form-label">전화번호 </label></div>
												    		<div class="col-9"><input type="text" class="form-control" id="call" name="call" value="${item.eCall }" readonly></div>
														</div>
												    	
												    	<div class="mb-3 row">
												    		<div class="col-3"><label for="hiredate" class="form-label">가입일 </label></div>
												    		<div class="col-9"><input type="text" class="form-control" id="hiredate" name="hiredate" value="${item.hiredate }" readonly></div>
														</div>
											    </div>
											  </div>
											</div>
										</div>
										
										<td>${item.storeNum }</td>
										<td>${item.role }</td>
										<td><a href="acceptAdmin.jsp?empno=${item.empNo}" class="btn btn-success btn-sm">승인</a></td>
										<td><a href="deleteAdmin.jsp?empno=${item.empNo}" class="btn btn-danger btn-sm">거절</a></td>
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
	</div>
	
	<!-- 푸터 -->
  	<jsp:include page="/include/footer.jsp" />
	
	
</body>
</html>