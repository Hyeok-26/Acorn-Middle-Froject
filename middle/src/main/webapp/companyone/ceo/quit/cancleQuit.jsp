<%@page import="test.dao.Com1EmpDao"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 취소 대상의 사원번호(empno)
	int empno = Integer.parseInt(request.getParameter("empno"));
	System.out.println(empno);
	
	// 퇴사처리할 사람 정보 DTO 가져오기
	Com1EmpDto dto = Com1EmpDao.getInstance().getData(empno);
	
	Com1EmpDto dto_emp = new Com1EmpDto();
	dto_emp.setComId(dto_quit.getComId());
	dto_emp.setContract(dto_quit.getContract());
	dto_emp.seteCall(dto_quit.getContract());
	dto_emp.setEmail(dto_quit.getEmail());
	dto_emp.setEmpNo(dto_quit.getEmpNo());
	dto_emp.seteName(dto_quit.geteName());
	dto_emp.setePwd(dto_quit.getePwd());
	dto_emp.setHiredate(dto_quit.getHiredate());
	dto_emp.setHsal(dto_quit.getHsal());
	dto_emp.setRole(dto_quit.getRole());
	dto_emp.setSal(dto_quit.getSal());
	dto_emp.setStoreNum(dto_quit.getStoreNum());
	dto_emp.setWorktime(dto_quit.getWorktime());
	
	// quit 테이블에서 그 사람 row 추가
	boolean isAddSuccess = Com1QuitDao.getInstance().insert(dto,quitdate);
	
	// emp 테이블에서 그 사람 row 삭제
	boolean isDeleteSuccess = Com1EmpDao.getInstance().delete(empno);
	
	System.out.println("isAddSuccess 결과: " + isAddSuccess);
	System.out.println("isDeleteSuccess 결과: " + isAddSuccess);
%>
{"isAddSuccess":<%=isAddSuccess %>,"isDeleteSuccess":<%=isDeleteSuccess %>}