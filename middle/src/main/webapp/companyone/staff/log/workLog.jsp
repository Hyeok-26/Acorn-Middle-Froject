<%@page import="java.sql.Timestamp"%>
<%@page import="test.dao.Com1EmpLogDao"%>
<%@page import="test.dto.Com1EmpLogDto"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//
	int empno = Integer.parseInt(request.getParameter("empno"));
	String checkin = request.getParameter("checkin");
	String checkout = request.getParameter("checkout");
	 
	Com1EmpLogDto dto = new Com1EmpLogDto();
	dto.setEmpno(empno);
	
	System.out.println(checkin);
	System.out.println(checkout);
	
	boolean isSuccess = true;

	if (checkin != null) {
        // 출근 처리
        isSuccess = Com1EmpLogDao.getInstance().insertStart(dto);
    } else if (checkout != null) {
        // 퇴근 처리
        isSuccess = Com1EmpLogDao.getInstance().updateFinish(dto);
    }
%>
{
	"isSuccess":"<%=isSuccess %>"
}