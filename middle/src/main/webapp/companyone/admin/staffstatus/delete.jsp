<%@page import="test.dao.Com1EmpLogDao"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	int num = Integer.parseInt(request.getParameter("empno"));
	Com1EmpDao dao=Com1EmpDao.getInstance();
	Com1EmpLogDao logdao=Com1EmpLogDao.getInstance();
	boolean logisSuccess= logdao.delete(num);
	boolean isSuccess= dao.delete(num);

	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원삭제</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
</head>
<body>
	<div class="container mt-5">
		<h3>알림</h3>
		<%if(isSuccess || logisSuccess){ %>
			<p class="alert alert-success">
				<strong><%=num %></strong>번 사원의 정보를 삭제했습니다.
				<a class="alert-link" href="view.jsp">확인</a>
			</p>
		<%}else{ %>
			<p class="alert alert-danger">
				삭제 실패!
				<a class="alert-link" href="view.jsp">확인</a>
			</p>
		<%} %>
	</div>
</body>
</html>