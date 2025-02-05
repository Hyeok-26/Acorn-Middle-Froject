<%@page import="test.dto.Com1CeoDto"%>
<%@page import="test.dao.Com1CeoDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%

	int empno = (int) session.getAttribute("empno");
	Com1CeoDao dao = Com1CeoDao.getInstance();
	Com1CeoDto dto = dao.getData(empno);
	

	String newcall=request.getParameter("callnum");
	String password=request.getParameter("password");
	String newPassword=request.getParameter("newPassword");	
	boolean isSuccess=false;

	if(newcall!=null&&newPassword!=null){
		dto.seteCall(newcall);
		Com1CeoDao.getInstance().update(dto);
		dto.setePwd(newPassword);
		Com1CeoDao.getInstance().update(dto);
		isSuccess=true;
	}
	
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<div class="container">
	<%if(isSuccess==true){ %>
		<script>
			alert("개인 정보를 수정했습니다.");
			//javascript 로 페이지 이동
			location.href = "${pageContext.request.contextPath }/companyone/ceo/ceoMain.jsp";
		</script>
	<%}else{ %>
		<script>
			alert("개인정보를 수정하지 못 했습니다.");
			//javascript 로 페이지 이동
			location.href = "updateform.jsp";
		</script>
	<%} %>
</div>
</body>
</html>