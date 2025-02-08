<%@page import="test.dto.Com1SaleDto"%>
<%@page import="test.dao.Com1SaleDao"%>
<%@page import="test.dao.Com1Dao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	//현재 페이지 위치를 세션 영역에 저장 (관리자 전용 네비바에 활성 상태 표시 위함)
	session.setAttribute("current_page", "view");

	//로그인 상태 표시 : 세션 영역에서 접속 계정 정보 가져오기
	String comname = (String)session.getAttribute("comname");
	String ename = (String)session.getAttribute("ename");

	// DB 에서 조회할 때 넘겨줄 객체
	Com1SaleDao saledao = Com1SaleDao.getInstance(); 
	Com1SaleDto dto = new Com1SaleDto();

	// 몇 호점 리스트 정보 가져오기
	List<Integer> storeList = Com1Dao.getInstance().getStoreNumList();
	pageContext.setAttribute("storeList", storeList);

	// 보여줄 조건 기본 값
	int storenum = 1;
		
	// 보여줄 조건을 파라미터로 받기

	String strStoreNum = request.getParameter("storenum"); 		// 1 | 2 | 3 ...
	List<Com1SaleDto> listall= saledao.getListAll();
	List<Com1SaleDto> listsalemonth = saledao.getListSalebyMonth();
	List<Com1SaleDto> listsaleyear = saledao.getListSalebyYear();
	List<Com1SaleDto> listbystore =null;
	List<Com1SaleDto> listbystoremonthly =null;
	List<Com1SaleDto> listbystoreyearly=null;
	
	if(strStoreNum!=null){
		storenum = Integer.parseInt(strStoreNum);
		listbystore = saledao.getListbyStore(storenum);
		listbystoremonthly = saledao.getListMonthlybyStore(storenum);
		listbystoreyearly= saledao.getListYearlybyStore(storenum);
	}

	// request 영역에 필요한 정보 저장
	request.setAttribute("storenum", storenum);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 페이지 로딩에 필요한 자원 -->
<jsp:include page="/include/resource.jsp"></jsp:include>
</head>
<body>
	<%-- 관리자 페이지 전용 네비바 --%>
	<jsp:include page="/include/ceoNav.jsp"></jsp:include>

	<!-- 현재 접속 상태 표시 -->
	<div class="container">
		<p><%=comname %>의
			<%=ename %>님 접속 중
		</p>
	</div>


	<!-- 본문 -->
	<div class="contents text-center mt-3 mx-auto" style="width: 900px;">
		<h4>매출 현황</h4>

		<!-- 조회 조건 -->
		<div class="tab-button" >
			<ul class="nav nav-tabs">
				<li class=" nav-item" id="allTab" onclick="switchTab('all')" ><a class="nav-link" aria-current="page" href="view.jsp" >매출 전체</a></li><%--매장상관없이 전체 일매출 --%>
				<li class="nav-item" id="allyearTab"><a class="nav-link" aria-current="page"href="view.jsp" onclick="switchTab('allyear')">연매출</a></li><%--매장상관없이 연매출: 년/월/일, 매출 --%>
				<li class="nav-item" id="allmonthTab" ><a class="nav-link" aria-current="page" href="view.jsp" onclick="switchTab('allmonth')">월매출</a></li><%--매장상관없이 월매출 : 년/월/일,매출 --%>

				<li class="nav-item dropdown" id="allstore" ><a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" onclick="switchTab('allstore')"
					role="button" aria-expanded="false"> 호점 별 매출</a>
					<form action="view.jsp" method>
					
					</form>
					<ul class="dropdown-menu">
						<c:forEach var="num" items="${storeList}">
							<li><a class="dropdown-item" href="viewsale.jsp">${num}</a></li>
						</c:forEach>
					</ul></li>
			</ul>
		</div>


		<!-- 전체매출 탭 -->
		<div id = "allContent" class="tab-content p-3 bg-light rounded shadow-sm"
			style="height: 500px">
			<div class="table-responsive">
				<table class="table table-hover text-center align-middle">
					<thead class="table-dark">
						<tr>
							<th>호점</th>
							<th>년/월/일</th>
							<th>매출</th>
						</tr>
					</thead>
					<tbody>
						<% if (listall != null && !listall.isEmpty()) { 
				            for (Com1SaleDto tmp : listall) { %>
					<tr>
						<td><%= tmp.getStoreNum() %></td>
						<td><%= tmp.getSalesDate() %></td>
						<td><%= tmp.getDailySales() %></td>
					</tr>
					<%  } 
				           } else { %>
					<tr>
						<td>매출 정보가 없습니다.</td>
					</tr>
					<% } %>
					</tbody>
				</table>
			</div>
		</div>
		<%-- 연매출 탭 --%>
		<div id = "allyearContent" class="tab-content p-3 bg-light rounded shadow-sm"
			style="height: 500px">
			<div class="table-responsive">
				<table class="table table-hover text-center align-middle">
					<thead class="table-dark">
						<tr>
							<th>년/월/일</th>
							<th>매출</th>
						</tr>
					</thead>
					<tbody>
						<% if (listsaleyear != null && !listsaleyear.isEmpty()) { 
				            for (Com1SaleDto tmp : listsaleyear) { %>
					<tr>
						<td><%= tmp.getYear() %></td>
						<td><%= tmp.getYearlySales() %></td>
					</tr>
					<%  } 
				           } else { %>
					<tr>
						<td>매출 정보가 없습니다.</td>
					</tr>
					<% } %>
					</tbody>
				</table>
			</div>
		</div>
		<%-- 월매출 탭--%>
		<div id = "allmonthContent" class="tab-content p-3 bg-light rounded shadow-sm"
			style="height: 500px">
			<div class="table-responsive">
				<table class="table table-hover text-center align-middle">
					<thead class="table-dark">
						<tr>
							<th>년/월</th>
							<th>매출</th>
						</tr>
					</thead>
					<tbody>
						<% if (listsalemonth != null && !listsalemonth.isEmpty()) { 
				            for (Com1SaleDto tmp : listsalemonth) { %>
					<tr>
						<td><%= tmp.getMonth() %></td>
						<td><%= tmp.getDailySales() %></td>
					</tr>
					<%  } 
				           } else { %>
					<tr>
						<td >매출 정보가 없습니다.</td>
					</tr>
					<% } %>
					</tbody>
				</table>
			</div>
		</div>
		<%-- 매장별 조회 --%>
		<div id = "allstoreContent" class="tab-content p-3 bg-light rounded shadow-sm"
			style="height: 500px">
			<div class="table-responsive">
				<table class="table table-hover text-center align-middle">
					<thead class="table-dark">
						<tr>
							<th>년/월/일</th>
							<th>매출</th>
						</tr>
					</thead>
					<tbody>
						<% if (listbystore != null && !listbystore.isEmpty()) { 
				            for (Com1SaleDto tmp : listbystore) { %>
					<tr>
						<td><%= tmp.getSalesDate() %></td>
						<td><%= tmp.getDailySales() %></td>
					</tr>
					<%  } 
				           } else { %>
					<tr>
						<td>매출 정보가 없습니다.</td>
					</tr>
					<% } %>
					</tbody>
				</table>
			</div>
			<div class="table-responsive">
				<table class="table table-hover text-center align-middle">
					<thead class="table-dark">
						<tr>
							<th>년/월/일</th>
							<th>매출</th>
						</tr>
					</thead>
					<tbody>
						<% if (listbystoremonthly!= null && !listbystoremonthly.isEmpty()) { 
				            for (Com1SaleDto tmp : listbystoremonthly) { %>
					<tr>
						<td><%= tmp.getMonth() %></td>
						<td><%= tmp.getMonthlySales() %></td>
					</tr>
					<%  } 
				           } else { %>
					<tr>
						<td>매출 정보가 없습니다.</td>
					</tr>
					<% } %>
					</tbody>
				</table>
			</div>
			<div class="table-responsive">
				<table class="table table-hover text-center align-middle">
					<thead class="table-dark">
						<tr>
							<th>년/월/일</th>
							<th>매출</th>
						</tr>
					</thead>
					<tbody>
						<% if (listbystoreyearly!= null && !listbystoreyearly.isEmpty()) { 
				            for (Com1SaleDto tmp : listbystoreyearly) { %>
					<tr>
						<td><%= tmp.getYear() %></td>
						<td><%= tmp.getYearlySales() %></td>
					</tr>
					<%  } 
				           } else { %>
					<tr>
						<td>매출 정보가 없습니다.</td>
					</tr>
					<% } %>
					</tbody>
				</table>
			</div>
		</div>
		
	</div>



	<!-- 푸터 -->
	<div class="position-fixed bottom-0 w-100">
		<jsp:include page="/include/footer.jsp" />
	</div>
	<script>
	 function switchTab(tab) {
	        const tabs = ['all', 'allyear', 'allmonth', 'allstore'];
	
	        tabs.forEach(t => {
	            document.getElementById(t + 'Content').style.display = 'none';
	            document.getElementById(t + 'Tab').classList.remove('active-tab');
	        });
	
	        document.getElementById(tab + 'Content').style.display = 'block';
	        document.getElementById(tab + 'Tab').classList.add('active-tab');
	    }
	
	    window.onload = function() {
	        const tabs = ['all', 'allyear', 'allmonth', 'allstore'];
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