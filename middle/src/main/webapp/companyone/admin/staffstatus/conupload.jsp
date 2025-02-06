<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int empno = Integer.parseInt(request.getParameter("empno"));
	String srcurl = request.getParameter("srcurl");

	Com1EmpDao dao=Com1EmpDao.getInstance();
	
	Com1EmpDto dto= dao.getData(empno);
	dto.setContract(srcurl);

	boolean isSuccess=dao.update(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계약서업로드</title>
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
				<strong><%=empno %> <%=dto.geteName() %></strong>사원의 계약서 업로드됐습니다.
				<a class="alert-link" href="contract.jsp?empno=<%=empno%>">계약서 확인</a>
			</p>
		<%}else{ %>
			<p class="alert alert-danger">
				업로드 실패
				<a class="alert-link" href="conuploadform.jsp?empno=<%=empno %>">다시 업로드해주세요</a>
			</p>
		<% } %>
	
	
	
	
	
		</div>
	</div> <%--main --%>
	<%--푸터 --%>
    <jsp:include page="/include/footer.jsp" />
</body>
</html>