<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar" style="background-color: #495057;">
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath }/" style="color: white;">홈페이지</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath }/user/example.jsp" style="color: white;">회원가입</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" aria-expanded="false" style="color: white;">로그인</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#" style="color: black;">CEO</a></li>
                            <li><a class="dropdown-item" href="#" style="color: black;">점장</a></li>
                            <li><a class="dropdown-item" href="#" style="color: black;">직원</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" aria-expanded="false" style="color: white;">계정 설명</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#" style="color: black;">관리자계정</a></li>
                            <li><a class="dropdown-item" href="#" style="color: black;">지점장계정</a></li>
                            <li><a class="dropdown-item" href="#" style="color: black;">매장직원계정</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link active" style="color: white;">기능 추가..</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link disabled" aria-disabled="true" style="color: white;">추가 서비스 준비중...</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</div>
