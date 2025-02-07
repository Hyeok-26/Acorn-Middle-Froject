<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="test.dao.Com1SaleDao"%>
<%@page import="test.dto.Com1SaleDto"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	int storenum = (int)session.getAttribute("storenum");

	String selectday = request.getParameter("day");
	if(selectday != null){
		int daySale = Com1SaleDao.getInstance().getStoreDate(selectday, storenum);
		pageContext.setAttribute("salesdate", selectday);
		pageContext.setAttribute("daySale", daySale);
	};
	
	String selectmonth = request.getParameter("month");
	String selectyear = request.getParameter("year");
	if(selectmonth != null && selectyear != null){
		int month = Integer.parseInt(selectmonth);
		int year = Integer.parseInt(selectyear);
		Com1SaleDto dto = Com1SaleDao.getInstance().getStoreMonth(storenum, year, month);
		pageContext.setAttribute("dto", dto);
	} else if(selectyear != null){
		int year = Integer.parseInt(selectyear);
		Com1SaleDto dto2 = Com1SaleDao.getInstance().getStoreYear(storenum, year);
		pageContext.setAttribute("dto2", dto2);
		
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진짜 매출 조회 페이지</title>
</head>
<body>
	<div class="container">
		<h1>원하는 날짜의 일 매출 조회하기</h1>
		<form action="salemanage2.jsp" method="get">
			<input type="date" name="day" required />
			<button type="submit">조회</button>
		</form>
		<table>
			<thead>
				<tr>
					<th>선택한 날짜</th>
					<th>일 매출</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>${salesdate }</th>
					<th>${daySale }</th>
				</tr>
			</tbody>
		</table>
	</div>
	<%-- <div class="container">
		<h1>원하는 달의 모든 매출 조회하기</h1>
		<form action="salemanage2.jsp" method="get">
			<input type="number" name="year" required />
			<button type="submit">조회</button>
		</form>
		<table>
			<thead>
				<tr>
					<th>선택한 날짜</th>
					<th>일 매출</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>${salesdate }</th>
					<th>${daySale }</th>
				</tr>
			</tbody>
		</table>
	</div> --%>
	<div class="container">
		<h1>원하는 달의 달 매출 조회하기</h1>
		<form action="salemanage2.jsp" method="get">
			<input type="number" name="year" required />
			<input type="number" name="month" required/>
			<button type="submit">조회</button>
		</form>
		<table>
			<thead>
				<tr>
					<th>선택한 년도</th>
					<th>선택한 월</th>
					<th>월 매출</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>${dto.year }</th>
					<th>${dto.month }</th>
					<th>${dto.monthlySales }</th>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="container">
		<h1>원하는 년도의 연 매출 조회하기</h1>
		<form action="salemanage2.jsp" method="get">
			<input type="number" name="year" required />
			<button type="submit">조회</button>
		</form>
		<table>
			<thead>
				<tr>
					<th>선택한 년도</th>
					<th>년 매출</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>${dto2.year }</th>
					<th>${dto2.yearlySales }</th>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>
