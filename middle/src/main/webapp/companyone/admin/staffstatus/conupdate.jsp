<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int empno = Integer.parseInt(request.getParameter("empno"));
	Com1EmpDao dao=Com1EmpDao.getInstance();
	Com1EmpDto dto= dao.getData(empno);
	dto.setContract("");
	boolean isSuccess=dao.update(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계약서삭제</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<%--main컨텐츠감싸기 --%>
	<div class="main flex-grow-1"> 
		<div class="container mt-5"> 
	
	
		<h3>알림</h3>
		<%if(isSuccess){ %>
			<p class="alert alert-success">
				<strong><%=empno %> <%=dto.geteName() %></strong>사원의 계약서가 삭제되었습니다..
				<a class="alert-link" href="contract.jsp?empno=<%=empno%>">계약서 확인</a>
				<a class="alert-link" href="view.jsp">직원현황 확인하러가기</a>
			</p>
		<%}%>
	
	
	
	
	
		</div>
	</div> <%--main --%>
	<%--푸터 --%>
    <jsp:include page="/include/footer.jsp" />
</body>
</html>