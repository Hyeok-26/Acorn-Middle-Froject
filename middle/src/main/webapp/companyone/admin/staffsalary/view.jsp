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
<title>직원월급</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	
	<%--main컨텐츠감싸기 --%>
	<div class="main flex-grow-1">  
		<div class="container">
			
			<%--직원div --%>
			<div class="row justify-content-center mb-3">
            	<div class="col-xl">
                	<div class="card p-4">
						<h1 class="mb-4">직원 월급</h1>
						<%--직원 월급 테이블--%>
						<table class="table table-borederd table-hover text-center">
							<thead class="table-dark">
								<tr>
									<th>사번</th>
									<th>이름</th>
									<th>월급</th>
								</tr>
							</thead>
							<tbody>
								<% for(Com1EmpDto tmp:list){
									 if (tmp.getSal() != 0) {
								%>
								<tr>
									<td><%=tmp.getEmpNo()%></td>
									<td><%=tmp.geteName()%></td>
									<td><%=tmp.getSal()%></td>
								</tr>
								<%} }%>
							</tbody>
						</table>
           			</div>
            	</div>
            </div>				

			<%--알바div --%>
			<div class="row justify-content-center mb-3">
            	<div class="col-xl">
                	<div class="card p-4">          
            	
						<h1 class="mb-4">알바 월급</h1>
						<%--알바 월급 테이블--%>
						<table class="table table-borederd table-hover text-center">
							<thead class="table-dark">
								<tr>
									<th>사번</th>
									<th>이름</th>
									<th>시급</th>
									<th>일한시간</th>
									<th>월급</th>
								</tr>
							</thead>
							<tbody>
								<% for(Com1EmpDto tmp:list){
									 if (tmp.getHsal() != 0) {
								%>
								<tr>
									<td><%=tmp.getEmpNo()%></td>
									<td><%=tmp.geteName()%></td>
									<td><%=tmp.getHsal()%></td>									
									<td><%=tmp.getWorktime()%></td>
									<td><%=tmp.getHsal()*tmp.getWorktime()%></td>	
								</tr>
							<%} }%>
							</tbody>
						</table>
			    	</div>
            	</div>
            </div>
            
		</div>	<%--container --%>
    </div> <%--main --%>

	
	<%--푸터 --%>
    <jsp:include page="/include/footer.jsp" />
</body>
</html>