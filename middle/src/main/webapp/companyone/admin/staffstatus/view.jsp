<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//dao이용해서 회원목록 얻어오기
	Com1EmpDao dao=Com1EmpDao.getInstance();
	List<Com1EmpDto> list=dao.getListStaff();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원관리</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	
	<%--main컨텐츠감싸기 --%>
	<div class="main flex-grow-1">  
		<div class="container">

		
			<h1>직원관리 페이지</h1>
    	    
			<%--테이블--%>
			<table class="table table-borederd table-hover text-center">
				<thead class="table-dark">
					<tr>
						<th>회사ID</th>
						<th>소속지점</th>
						<th>사번</th>
						<th>이름</th>
						<th>연락처</th>
						<th>월급</th>
						<th>시급</th>
						<th>일한시간</th>
						<th>이메일</th>
						<th>근로계약서보기</th>
						<th>근로시간변경</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<% for(Com1EmpDto tmp:list){%>
					<tr>
						<td><%=tmp.getComId()%></td>
						<td><%=tmp.getStoreNum()%></td>
						<td><%=tmp.getEmpNo()%></td>
						<td><%=tmp.geteName()%></td>
						<td><%=tmp.geteCall()%></td>
						<td><%=tmp.getSal()%></td>
						<td><%=tmp.getHsal()%></td>
						<td><%=tmp.getWorktime()%></td>
						<td><%=tmp.getEmail()%></td>										
						<td>
							<a href="contract.jsp?empno=<%=tmp.getEmpNo()%>">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-earmark-person" viewBox="0 0 16 16">
							  <path d="M11 8a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
							  <path d="M14 14V4.5L9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2M9.5 3A1.5 1.5 0 0 0 11 4.5h2v9.255S12 12 8 12s-5 1.755-5 1.755V2a1 1 0 0 1 1-1h5.5z"/>
							</svg>
							<span>근로계약서</span>
							</a>
						</td>
						<td><a href="salupdateform.jsp?empno=<%=tmp.getEmpNo()%>">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
						  <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
						  <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z"/>
						</svg>
						<span class="visually-hidden">근로시간변경</span>
						</a></td>
						<td>
							<a href="delete.jsp?empno=<%=tmp.getEmpNo()%>"> 
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-dash" viewBox="0 0 16 16">
	  							 <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7M11 12h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1 0-1m0-7a3 3 0 1 1-6 0 3 3 0 0 1 6 0M8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4" />
	 							 <path d="M8.256 14a4.5 4.5 0 0 1-.229-1.004H3c.001-.246.154-.986.832-1.664C4.484 10.68 5.711 10 8 10q.39 0 .74.025c.226-.341.496-.65.804-.918Q8.844 9.002 8 9c-5 0-6 3-6 4s1 1 1 1z" />
							</svg> 
							<span class="visually-hidden">회원삭제</span>
							</a>
						</td>						
					</tr>
				<%}%>	
				</tbody>
			</table>
		</div>
	</div> <%--메인 --%>


	<%--푸터 --%>
	<jsp:include page="/include/footer.jsp" />
</body>
</html>