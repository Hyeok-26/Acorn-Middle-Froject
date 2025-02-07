<%@page import="test.dao.UsingDao"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//입력한 데이터 가져오기
	int storenum = Integer.parseInt(request.getParameter("storenum"));
	int empno = Integer.parseInt(request.getParameter("empno"));
	String ename = request.getParameter("ename");
	String phonenum= request.getParameter("phonenum");
	String epwd = request.getParameter("epwd");	
	int sal=Integer.parseInt(request.getParameter("sal"));
	String email=request.getParameter("email");
	
	// DTO 객체 생성
	Com1EmpDto dto = new Com1EmpDto();
	
	// 데이터 저장 
	dto.setStoreNum(storenum);
	dto.setEmpNo(empno);
	dto.seteName(ename);
	dto.seteCall(phonenum);
	dto.setePwd(epwd);
	dto.setSal(sal);
	dto.setEmail(email);
	
	//입력한 데이터로 수정하기
	boolean isSuccess=Com1EmpDao.getInstance().update(dto);
	//수정을 성공했다면 알림뜨고 index로 이동
	if(isSuccess){
		session.setAttribute("dto",dto);
%>
	<script>
		alert("수정 성공!");
		window.location.href = "<%= request.getContextPath() %>/companyone/admin/adminMain.jsp";
	</script>
<%
	} else{
%>
	<script>
		alert("수정 실패!");
		 window.location.href = "<%= request.getContextPath() %>/companyone/admin/info/updateform.jsp";
	</script>
<%
	}
	
%>
