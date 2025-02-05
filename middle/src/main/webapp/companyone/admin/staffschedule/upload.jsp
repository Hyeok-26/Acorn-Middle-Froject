<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String month="????-??월 근무표 업로드되었습니다.";
	boolean isSuccess=true;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스케쥴업로드확인</title>
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
				<strong><%=month %></strong>님의 정보를 저장했습니다.
				<a class="alert-link" href="EmpSchedule.jsp">근무표확인</a>
			</p>
		<%}else{ %>
			<p class="alert alert-danger">
				업로드 실패
				<a class="alert-link" href="ScheduleUploadform.jsp">다시 업로드해주세요</a>
			</p>
		<% } %>
	
	
	
	
	
		</div>
	</div> <%--main --%>
	<%--푸터 --%>
    <jsp:include page="/include/footer.jsp" />
</body>
</html>