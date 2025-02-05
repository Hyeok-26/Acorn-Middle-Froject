<%@page import="test.dto.Com1QuitDto"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@page import="test.dao.Com1QuitDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 정보 추가에 필요한 데이터 추출 : 사원번호(empno), 퇴사일자(quitdate)
	int empno = Integer.parseInt(request.getParameter("empno"));
	String quitdate = request.getParameter("quitdate");
	
	// 퇴사처리할 사람 정보 DTO 가져오기
	Com1QuitDto dto_quit = Com1QuitDao.getInstance().getData(empno);
	
	
	// quit 테이블에서 그 사람 row 추가
	boolean isAddSuccess = Com1EmpDao.getInstance().insert(dto_quit,quitdate);
	
	// emp 테이블에서 그 사람 row 삭제
	boolean isDeleteSuccess = Com1EmpDao.getInstance().delete(empno);
	
	System.out.println("isAddSuccess 결과: " + isAddSuccess);
	System.out.println("isDeleteSuccess 결과: " + isAddSuccess);
%>
{"isAddSuccess":<%=isAddSuccess %>,"isDeleteSuccess":<%=isDeleteSuccess %>}