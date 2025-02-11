<%@page import="test.dao.Com1SchDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>
<%
	//int storenum = Integer.parseInt(request.getParameter("storenum"));
	String date = request.getParameter("date");
	Com1SchDao dao=Com1SchDao.getInstance();
	boolean isSuccess= dao.delete(storenum);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스케쥴삭제</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
	<jsp:include page="/include/adminNav.jsp"></jsp:include>
	<%--main컨텐츠감싸기 --%>
		<div class="main flex-grow-1"> 
			<div class="container mt-5">
			<h3>알림</h3>
			<%if(isSuccess){ %>
				<p class="alert alert-success">
					<strong><%=storenum %>호점 <%=date %>월</strong>근무표를 삭제했습니다.
					<a class="alert-link" href="view.jsp?storenum=<%=storenum %>">확인</a>
				</p>
			<%}else{ %>
				<p class="alert alert-danger">
					삭제 실패!
					<a class="alert-link" href="view.jsp?storenum=<%=storenum %>">확인</a>
				</p>
			<%} %>
		</div>
	</div> <%--main --%>
	<%--푸터 --%>
    <jsp:include page="/include/footer.jsp" />
</body>
</html>