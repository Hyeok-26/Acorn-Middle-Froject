<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header class="bg-dark text-white py-3">
    <div class="container d-flex justify-content-between align-items-center">
        <!-- 제목 클릭 시 새로 고침 되는 부분 -->
        <h1 class="m-0" onclick="refreshPage()">프랜차이즈 관리 시스템</h1>
        
        <nav class="nav">
            <a class="nav-link text-white" href="${pageContext.request.contextPath }/">홈</a>
            <a class="nav-link text-white" href="${pageContext.request.contextPath }/user/loginform.jsp">로그인</a>
            <a class="nav-link text-white" href="${pageContext.request.contextPath }/user/signup.jsp">회원가입</a>
        </nav>
    </div>
</header>

<script>
    function refreshPage() {
        window.location.href = "${pageContext.request.contextPath}/index.jsp"; // index.jsp 페이지로 리디렉션하면서 새로고침
    }
</script>
