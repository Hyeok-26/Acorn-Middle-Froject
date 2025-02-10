<%@page import="com.google.gson.Gson"%>
<%@page import="test.dto.Com1SaleDto"%>
<%@page import="java.util.List"%>
<%@page import="test.dao.Com1SaleDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String date = request.getParameter("date");
	List<Com1SaleDto> list=null;
	if(date != null){
		System.out.println("date:"+date);
		
		list = Com1SaleDao.getInstance().getListByDate(date);
	}
	Gson gson = new Gson();
%>
<%=gson.toJson(list)%>