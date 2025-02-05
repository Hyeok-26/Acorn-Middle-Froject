<%@page import="test.dao.Com1SchDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	int num = Integer.parseInt(request.getParameter("storenum"));
	String date = 	request.getParameter("date");
	Com1SchDao dao=Com1SchDao.getInstance();
	boolean isSuccess= dao.delete(num);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스케쥴삭제</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
</head>
<body>
	<div class="container mt-5">
		<h3>알림</h3>
		<%if(isSuccess){ %>
			<p class="alert alert-success">
				<strong><%=num %>호점 <%=date %>월</strong>근무표를 삭제했습니다.
				<a class="alert-link" href="EmpSchedule.jsp">확인</a>
			</p>
		<%}else{ %>
			<p class="alert alert-danger">
				삭제 실패!
				<a class="alert-link" href="EmpSchedule.jsp">확인</a>
			</p>
		<%} %>
	</div>
</body>
</html>