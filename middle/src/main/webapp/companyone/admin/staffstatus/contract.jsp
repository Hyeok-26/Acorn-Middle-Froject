<%@page import="test.dto.Com1EmpDto"%>
<%@page import="java.util.List"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("empno"));
	String name = request.getParameter("ename");
	String contract = request.getParameter("contract");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근로계약서조회</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	
	<%--main컨텐츠감싸기 --%>
	<div class="main flex-grow-1">  
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg">
                    <div class="card shadow-sm p-4">
						<h1>사번 : <%=num%> <%=name%> 사원의 근로계약서</h1>
                    	<img src="<%=contract%>" alt="근로계약서" />
                  </div>
              </div>                          
          </div>			
			
			
			
			
			
		</div>    	
    </div> <%--main --%>
	<%--푸터 --%>
    <jsp:include page="/include/footer.jsp" />
</body>
</html>