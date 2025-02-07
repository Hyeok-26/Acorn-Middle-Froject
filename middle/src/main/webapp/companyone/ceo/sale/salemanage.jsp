<%@page import="test.dao.Com1SaleDao"%>
<%@page import="test.dao.Com1Dao"%>
<%@page import="test.dto.Com1Dto"%>
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
	
	
	List<Integer> storenums = Com1Dao.getInstance().getStoreNumList();
	List<Com1SaleDto> listall = saledao.getListAll();
	

	//List<Com1SaleDto> listyear=SaleDao.getListYear();
	//int year = SaleDao.getListYear();
	//List<Com1SaleDto> listmonth=SaleDao.getListMonth(year);
	
	
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
		<div class="tab-button" id="allTab" onclick="switchTab('all')">전체 매출</div>
		<div class="tab-button" id="allyearTab" onclick="switchTab('allyear')">전체 연매출</div>
		<div class="tab-button" id="allmonthTab" onclick="switchTab('allmonth')">전체 월매출</div>
	
		<div id="allContent" class="tab-content"
			style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: block;">
			<table style="width: 100%; border-collapse: collapse;">
				<thead>
					<tr >
						<th>호점</th>
						<th>날짜</th>
						<th>매출</th>
					</tr>
				</thead>
				<tbody>
					<%
					int totalSales = 0; // 총합을 저장할 변수 선언

					if (listall != null && !listall.isEmpty()) {
						for (Com1SaleDto tmp : listall) {
					%>
					<tr>
						<td><%=tmp.getStoreNum()%></td>
						<td><%=tmp.getSaleDate()%></td>
						<td><%=tmp.getDailySales()%></td>
					</tr>
					<%
					totalSales += tmp.getDailySales(); // 매출을 합산
						}
					}
					%>
					<tr>
						<td>총합</td>
						<td><%=totalSales%></td>
						<!-- 총합 출력 -->
					</tr>
				</tbody>
			</table>
		</div>
		<div id="allyearContent" class="tab-content" style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: block;">
			<form action="saleview.jsp">
				<label for="storenum">지점 입력: </label>
				<input type="text" id="storenum" name="storenum" placeholder="지점명을 입력하세요" required>
			</form>
			
			<h3>지점별 연매출</h3>
			<table>
				<thead>
					<tr>
						<th>호점</th>
						<th>연도</th>
						<th>매출</th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
			</table>
		</div>
		<div id="allmonthContent" class="tab-content"
			style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: block;">
			
			
			<h3>지점별 월매출 목록</h3>
	
			<table>
				<thead>
					<tr>
						<th>호점</th>
						<th>날짜</th>
						<th>이름</th>
					</tr>
				</thead>
		
			</table>
		</div>
	</div>
	<%@ include file="/include/footer.jsp"%>
	<script>
	    function switchTab(tab) {
	        const tabs = ['all', 'allyear', 'allmonth'];
	
	        tabs.forEach(t => {
	            document.getElementById(t + 'Content').style.display = 'none';
	            document.getElementById(t + 'Tab').classList.remove('active-tab');
	        });
	
	        document.getElementById(tab + 'Content').style.display = 'block';
	        document.getElementById(tab + 'Tab').classList.add('active-tab');
	    }
	
	    window.onload = function() {
	        const tabs = ['all', 'allyear', 'allmonth'];
	        tabs.forEach(t => {
	            document.getElementById(t + 'Content').style.display = 'none';
	            document.getElementById(t + 'Tab').classList.remove('active-tab');
	        });
	        const urlParams = new URLSearchParams(window.location.search);
	        if (urlParams.has('storenum')) {
	            switchTab('storeNum');
	        }
	    };
	</script>
</body>
</html>



