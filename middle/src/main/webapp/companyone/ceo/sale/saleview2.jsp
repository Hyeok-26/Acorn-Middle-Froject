<%@page import="test.dto.Com1SaleDto"%>
<%@page import="java.util.List"%>
<%@page import="test.dao.Com1SaleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//현재 페이지 위치를 세션 영역에 저장 (관리자 전용 네비바에 활성 상태 표시 위함)
	session.setAttribute("current_page", "salemanage");
	//로그인 상태 표시 : 세션 영역에서 접속 계정 정보 가져오기
	String comname = (String)session.getAttribute("comname");
    String ename = (String)session.getAttribute("ename");
	Com1SaleDao saledao = Com1SaleDao.getInstance();

	
	/* int year=-1;
	int month=-1;
	int storenum=-1; */
	
	/*
		1. 아무것도 안넘어오는 경우
		2. year 만 넘어오는 경우
		3. year , month 만 넘어오는 경우 
	*/
	int storenum = Integer.parseInt(request.getParameter("storenum"));
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("year"));
	/* String strMonth=request.getParameter("month");
	String strStorenum=request.getParameter("storenum"); */

	List<Com1SaleDto> list = null;
	
	/* if(strYear!=null && strYear.isEmpty() && strMonth==null&&strMonth.isEmpty() && strStorenum!=null&& !strStorenum.isEmpty()){ //년 만 넘어오는 경우
		year = Integer.parseInt(strYear);
		storenum= Integer.parseInt(strStorenum);
		list=saledao.getStoreYearlySales(year, storenum);
		
	}else if(strYear!=null&&strYear.isEmpty() && strMonth!=null&&!strMonth.isEmpty() && strStorenum!=null&&!strStorenum.isEmpty()){//년, 월 만 넘어오는 경우
		year = Integer.parseInt(strYear);
		month = Integer.parseInt(strMonth);
		storenum= Integer.parseInt(strStorenum);
		list=saledao.getStoreMonthlySales(year, month,storenum);
	}else{//아무것도 안넘어오는 경우 
		list=saledao.getListAll();
	} */
	
	

	
	
	//Com1SaleDto dtomonth = saledao.getStoreMonth(storenum, year, month);
	//Com1SaleDto dtoyear = saledao.getStoreYear(storenum, year);
	

	
	//Com1Dao com1Dao = Com1Dao.getInstance();
	//String storenumParam = request.getParameter("storenum");
   	//int storenum = -1; 	
  	//List<Com1SaleDto> storeList = null;


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%-- <div>
		<table>
			<thead>
				<tr>
					<th>날짜</th>
					<th>매출</th>
				</tr>
			</thead>
			<tbody>
				<%for (Com1SaleDto tmp : list) { %>
				<tr>
					<td><%=tmp.getStoreNum() %></td>
					<td><%=tmp.getSalesDate() %></td>
					<td><%=tmp.getDailySales() %></td>


				</tr>
				<%}%>
			</tbody>
		</table>
	</div> --%>
	<div>
		<form action="saleview2.jsp" method="get">
			<input type="number" name="storenum" placeholder="매장번호" />
			<input type="number" name="year" placeholder="년도" />
			<input type="number" name="month" placeholder="달"/>
			<button type="submit">특정매장특정호점월매출</button>
		</form>
	</div>

</body>
</html>