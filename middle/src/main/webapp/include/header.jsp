<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<%
	int comid = -1;
	String comname = null;
	int empno = -1;
	String role = null;
	String ename = null;
	int storenum = -1;

	if (session.getAttribute("role") != null) {
		comid = (int)session.getAttribute("comid");
		comname = (String)session.getAttribute("comname");
		empno = (int)session.getAttribute("empno");
		role = (String)session.getAttribute("role");
		ename = (String)session.getAttribute("ename");
		storenum = (int)session.getAttribute("storenum");
	}

%>

<header class="bg-dark text-white py-3">
    <div class="container d-flex justify-content-between align-items-center">
        <!-- 제목 클릭 시 새로 고침 되는 부분 -->
        <h1 class="m-0" onclick="refreshPage()"  style="cursor: pointer;">프랜차이즈 관리 시스템</h1>
        
        <nav class="nav">
            <% if (role == null) { %>
            	<a class="nav-link text-white" href="${pageContext.request.contextPath }/">홈</a>
            	<a class="nav-link text-white" href="${pageContext.request.contextPath }/user/loginForm.jsp">로그인</a>
            	<a class="nav-link text-white" href="${pageContext.request.contextPath }/user/signup.jsp">회원가입</a>
            <% } else if(role.equals("CEO")){ %>
            	<a class="nav-link text-white" href="${pageContext.request.contextPath }/companyone/ceo/ceoMain.jsp">홈</a>
            	<p class="nav-link text-white"><%=ename %>님 접속 중</p>
            	<a class="nav-link text-white" href="${pageContext.request.contextPath }/user/logout.jsp">로그아웃</a>
            <% } else if(role.equals("ADMIN")) {%>
            	<a class="nav-link text-white" href="${pageContext.request.contextPath }/companyone/admin/adminMain.jsp">홈</a>
            	<p class="nav-link text-white"><%=ename %>님 접속 중</p>
            	<a class="nav-link text-white" href="${pageContext.request.contextPath }/user/logout.jsp">로그아웃</a>
            <% } else { %>
            	<a class="nav-link text-white" href="${pageContext.request.contextPath }/companyone/staff/staffMain.jsp">홈</a>
            	<p class="nav-link text-white"><%=ename %>님 접속 중</p>
            	<a class="nav-link text-white" href="${pageContext.request.contextPath }/user/logout.jsp">로그아웃</a>
            <%} %>
        </nav>
    </div>
</header>

<script>
    function refreshPage() {
        window.location.href = "${pageContext.request.contextPath}/index.jsp"; // index.jsp 페이지로 리디렉션하면서 새로고침
    }
</script>
