<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>
<%

	String returnurl = request.getParameter("returnurl");
	empno = Integer.parseInt(request.getParameter("empno"));
	ename = request.getParameter("ename");
	int sal = Integer.parseInt(request.getParameter("sal"));
	int hsal = Integer.parseInt(request.getParameter("hsal"));
	int worktime = Integer.parseInt(request.getParameter("worktime"));
	
	Com1EmpDao dao=Com1EmpDao.getInstance();
	
	Com1EmpDto dto= dao.getData(empno);
    dto.setSal(sal);
    dto.setHsal(hsal);
    dto.setWorktime(worktime);
    
    boolean isSuccess=dao.update(dto);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>급여, 근무시간수정</title>
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
				<strong><%=empno %> <%=ename %></strong>사원의 급여 및 근무시간 정보가 수정되었습니다.
				<a class="alert-link" href="<%=returnurl %>">변경정보 확인하기</a>
			</p>
		<%}else{ %>
			<p class="alert alert-danger">
				업로드 실패
				<a class="alert-link" href="salupdateform.jsp?empno=<%=empno %>">다시 업로드해주세요</a>
			</p>
		<% } %>
	
	
	
	
	
		</div>
	</div> <%--main --%>
	<%--푸터 --%>
    <jsp:include page="/include/footer.jsp" />
</body>
</html>