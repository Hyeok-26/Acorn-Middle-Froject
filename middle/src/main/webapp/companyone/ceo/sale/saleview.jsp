<%@page import="test.dao.Com1SaleDao"%>
<%@page import="java.util.ArrayList"%>

<%@page import="test.dto.Com1SaleDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//현재 페이지 위치를 세션 영역에 저장 (관리자 전용 네비바에 활성 상태 표시 위함)
	session.setAttribute("current_page", "salemanage");
	//로그인 상태 표시 : 세션 영역에서 접속 계정 정보 가져오기
	String comname = (String)session.getAttribute("comname");
    String ename = (String)session.getAttribute("ename");
	Com1SaleDao saledao = Com1SaleDao.getInstance();

	
	int year=-1;
	int month=-1;
	int storenum=-1;
	
	/*
		1. 아무것도 안넘어오는 경우
		2. year 만 넘어오는 경우
		3. year , month 만 넘어오는 경우 
	*/
	String strYear=request.getParameter("year");
	String strMonth=request.getParameter("month");
	String strStorenum=request.getParameter("storenum");

	List<Com1SaleDto> list = null;
	
	if(strYear!=null && strYear.isEmpty() && strMonth==null&&strMonth.isEmpty() && strStorenum!=null&& !strStorenum.isEmpty()){ //년 만 넘어오는 경우
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
	}
	
	

	
	
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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<jsp:include page="/include/resource.jsp"></jsp:include>
<style>
.tab-button {
	padding: 10px 20px;
	cursor: pointer;
	font-weight: bold;
	background-color: #f1f1f1;
	border: 1px solid #ddd;
	transition: background-color 0.3s ease;
	display: inline-block;
}

.active-tab {
	background-color: #dcdcdc;
	border-bottom: 2px solid #999;
}

.tab-content {
	padding: 20px;
	background-color: #fff;
	border-top: 1px solid #ddd;
	display: none;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	table-layout: fixed;
}

th, td {
	border: 1px solid #ddd;
	padding: 12px;
	text-align: center;
	background-color: #fff;
	font-size: 16px;
	white-space: normal;
	overflow-wrap: break-word;
	text-overflow: ellipsis;
	word-wrap: break-word;
}

th {
	background-color: #f5f5f5;
	font-weight: bold;
	color: #333;
	border-bottom: 2px solid #bbb;
}

tbody tr:nth-child(even) {
	background-color: #f9f9f9;
}

tbody tr:hover {
	background-color: #eef;
}

label {
	margin-right: 10px; /* 라벨과 입력란 사이의 간격 */
}

input {
	margin-bottom: 20px; /* 입력란 사이의 간격 */
	padding: 8px; /* 입력란에 여백 추가 */
}
</style>
</head>
<body class="d-flex flex-column min-vh-100">

	<div class="container">
		<p>
			<%-->	회사코드 :
			<%=comid %>
			회사번호 :
			<%=comname %>
			사원번호 :
			<%=empno %>
			역할 :
			<%=role %>
			이름 :
			<%=ename %> --%>
		</p>
	</div>
	<div class="container flex-fill" style="width: 100%; margin-top: 50px;">
		<form action="saleview.jsp" method="get">
			<label for="year">연도 입력: </label> 
			<input type="number" id="year" name="year" placeholder="연도를 입력하세요"> 
			<label for="month">월	입력: </label> <input type="number" id="month" name="month" placeholder="월을 입력하세요"> 
			<label for="storenum">지점 입력: </label> <input	type="number" id="storenum" name="storenum" placeholder="지점을 입력하세요">
			<button type="submit" id="submitbtn">조회</button>
		</form>




		<div  class="tab-content"
			style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: block;">
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
					
				<tr>
					<td>총합</td>
					<td></td>
					<td></td>
				</tr>
				
				</tbody>
				
			</table>
		</div>


	
	</div>
	<%@ include file="/include/footer.jsp"%>
	<script>

	</script>
</body>
</html>



