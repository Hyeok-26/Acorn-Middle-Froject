<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@page import="test.dao.Com1QuitDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 정보 추가에 필요한 데이터 추출 : 사원번호(empno), 퇴사일자(quitdate)
	int empno = Integer.parseInt(request.getParameter("empno"));
	String quitdate = request.getParameter("quitdate");
	
	// 퇴사처리할 사람 정보 DTO 가져오기
	Com1EmpDto dto = Com1EmpDao.getInstance().getData(empno);
	
	// emp 테이블에서 그 사람 row 삭제
	//boolean isDeleteSuccess = Com1EmpDao.getInstance().delete(empno);
	
	// quit 테이블에서 그 사람 row 추가
	boolean isAddSuccess = Com1QuitDao.getInstance().insert(dto,quitdate);
	System.out.println("isAddSuccess 결과: " + isAddSuccess);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		//if(isDeleteSuccess & isAddSuccess)
		if(<%=isAddSuccess %>){
			alert("퇴사 처리가 완료되었습니다.");
		} 
		location.href = "quit-form.jsp";
	</script>
</body>
</html>