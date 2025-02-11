<%@page import="test.dao.Com1Dao"%>
<%@page import="test.dto.Com1Dto"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	String storecall= request.getParameter("storecall");
	//Com1Dto dto = new Com1Dto();
	boolean isSuccess = false;
	
	if(storecall!=null){
		//dto.setStoreCall(storecall);
		
		isSuccess = Com1Dao.getInstance().insert(storecall);
		
	}
%>    
{"isSuccess" : <%=isSuccess %>}
