<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//dao 객체 생성
Com1EmpDao dao=Com1EmpDao.getInstance();
//직원의 empno를 session에 담아서 가져오기
int num=(int)session.getAttribute("empno");
//empno로 데이터 가져와서 dto에 담기 
Com1EmpDto dto=dao.getData(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근로계약서</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
<style>
	#app{
		height: auto;
		min-height: 100%;
	  	padding-bottom: 300px;
	}
	.footer{
	  height: 300px;
	  position : relative;
	  transform : translateY(-100%);
	}
</style>
</head>
<body>
<jsp:include page="/include/navbar.jsp"></jsp:include>
	<div class="container" id="app">
		<h1>근로 계약서 보기</h1>
		<div>
				<label><strong><%=dto.geteName() %></strong> 님의 근로계약서 입니다</label>
				<div>
					<a href="javascript:" id="contractLink">
						<%if(dto.getContract()==null){ %>
							<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-file-earmark-text" viewBox="0 0 16 16">
							  <path d="M5.5 7a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1zM5 9.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5"/>
							  <path d="M9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.5zm0 1v2A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1z"/>
							</svg>
						
						<%}else{ %>
							<img id="contractImage" src="${pageContext.request.contextPath}/upload/<%=dto.getContract() %>" alt="계약서 이미지" />
						<%} %>
					</a>
				</div>
			</div>
			
			<a href="${pageContext.request.contextPath }/download?orgFileName=${orgFileName}&saveFileName=${saveFileName}&fileSize=${fileSize}">파일 다운로드</a>
	
	</div>

<jsp:include page="/include/footer.jsp" />
</body>
</html>