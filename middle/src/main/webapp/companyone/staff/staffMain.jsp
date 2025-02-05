<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String comname = (String) session.getAttribute("comname");
	int storenum = (int) session.getAttribute("storenum");
	int empno = (int) session.getAttribute("empno");
	String role = (String) session.getAttribute("role");
	String ename = (String) session.getAttribute("ename");
	
	if(session.getAttribute("empno") == null) {
		response.sendRedirect("loginform.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 메인 페이지</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
<style>
    .container {
        max-width: 800px;
        margin: 40px auto;
        background-color: #fff;
        padding: 30px;
        border-radius: 8px;
        border: 1px solid black;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        text-align: center;
    }
    .btn-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 15px;
    }
    .btn-container button {
        width: 100%;
        max-width: 350px;
        height: 80px;
        font-size: 20px;
        border: 1px solid black;
        border-radius: 8px;
        transition: background-color 0.3s;
        background-color: #f8f9fa;
    }
    .btn-container button a {
        text-decoration: none;
        color: black;
        display: block;
        width: 100%;
        height: 100%;
        line-height: 80px;
    }
    .btn-container button:hover {
        background-color: #e2e6ea;
    }
</style>
</head>
<body>
<jsp:include page="/include/navbar.jsp"></jsp:include>
    <div class="container">
        <h2 class="text-center mb-4">직원 메인 페이지</h2>
        <h3>환영합니다, ${ename}님!</h3>
        <div class="btn-container">
        	<button><a href="${pageContext.request.contextPath }/staff/log/log.jsp">출/퇴근</a></button>
            <button><a href="${pageContext.request.contextPath }/staff/schedule/schedule.jsp">스케줄</a></button>
            <button><a href="${pageContext.request.contextPath }/staff/sal/salary.jsp">급여</a></button>
            <button><a href="${pageContext.request.contextPath }/staff/info/Profile.jsp">프로필 관리</a></button>
        </div>
    </div>
<jsp:include page="/include/footer.jsp" />
</body>
</html>