<%@page import="test.dto.Com1SchDto"%>
<%@page import="test.dao.Com1SchDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("storenum"));
	String month = request.getParameter("title");
	String srcurl = request.getParameter("srcurl");
	
	Com1SchDto dto = new Com1SchDto();
	dto.setStoreNum(num);
	dto.setSchdate(month);
	dto.setSrcurl(srcurl);

	Com1SchDao dao=Com1SchDao.getInstance();
	boolean isSuccess=dao.insert(dto);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스케쥴업로드확인</title>
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
				<strong><%=month %></strong>월 근무표 업로드됐습니다.
				<a class="alert-link" href="view.jsp?storenum=<%=num %>">근무표확인</a>
			</p>
		<%}else{ %>
			<p class="alert alert-danger">
				업로드 실패
				<a class="alert-link" href="uploadform.jsp?storenum=<%=num %>">다시 업로드해주세요</a>
			</p>
		<% } %>
	
	
	
	
	
		</div>
	</div> <%--main --%>
	<%--푸터 --%>
    <jsp:include page="/include/footer.jsp" />
</body>
</html>