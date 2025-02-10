<%@page import="test.dao.Com1SaleDao"%>
<%@page import="test.dao.Com1Dao"%>
<%@page import="test.dto.Com1SaleDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    //현재 페이지 위치를 세션 영역에 저장 (관리자 전용 네비바에 활성 상태 표시 위함)
	session.setAttribute("current_page", "view");
	//로그인 상태 표시 : 세션 영역에서 접속 계정 정보 가져오기
	String comname = (String)session.getAttribute("comname");
    String ename = (String)session.getAttribute("ename");
	Com1SaleDao saledao = Com1SaleDao.getInstance();
	List<Integer> storenums = Com1Dao.getInstance().getStoreNumList();
	
	int storenum=-1;
	List<Com1SaleDto> listall= saledao.getListAll();
	List<Com1SaleDto> listmonth = saledao.getListSalebyMonth();
	List<Com1SaleDto> listyear = saledao.getListSalebyYear();
	List<Com1SaleDto> listbystore =null;
	List<Com1SaleDto> listbystoremonthly =null;
	List<Com1SaleDto> listbystoreyearly=null;
	
	String strStoreNum=request.getParameter("storenum");
	if(strStoreNum!=null&&!strStoreNum.isEmpty()){
		storenum = Integer.parseInt(strStoreNum);
		listbystore = saledao.getListbyStore(storenum);
		listbystoremonthly = saledao.getListMonthlybyStore(storenum);
		listbystoreyearly= saledao.getListYearlybyStore(storenum);
	};
	request.setAttribute("storenum", storenum);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sale/view.jsp</title>
<style>
.table-container {
    padding-bottom: 100px; /* footer 높이보다 여유 있게 추가 */
}
</style>
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
	
	<!-- 조회조건 -->
	<div class="nav nav-tabs">
		<button class="tab-button nav-item nav-link" id="allTab" onclick="switchTab('all')">전체 매출</button>
		<button class="tab-button nav-item nav-link" id="yearTab" onclick="switchTab('year')">전체 연매출</button>
		<button class="tab-button nav-item nav-link" id="monthTab" onclick="switchTab('month')">전체 월매출</button>
		<div class="tab-button nav-item nav-link" id="storeTab" onclick="switchTab('store')">
			<form action="view.jsp" method="get" id="storeForm">
				<label for="storenum">지점 선택: </label> 
				<select name="storenum"	id="storenum" onchange="switchTab('store'); document.getElementById('storeForm').submit();">
					<option value="">-- 지점을 선택하세요 --</option>
					<% for (Integer tmp : storenums) { %>
					<option value="<%= tmp %>"	<%= (tmp.equals(storenum)) ? "selected" : ""%> > 	<%= tmp %>호점
					</option>
					<% } %>
				</select>				
			</form>		
		</div>
	</div>
	
	<div class="content text-center mt-3 mx-auto" style="width: 900px;">
		<div id="allContent" class="table-container tab-content p-3 bg-light rounded shadow-sm" style="display: block;">
			<div class="table-responsive">
				<table class="table table-hover text-center align-middle">
					<thead class="table-dark">
						<tr>
							<th>호점</th>
							<th>날짜 구분</th>
							<th>매출</th>
						</tr>
					</thead>
					<tbody>
						<% if (listall == null) { %>
							<tr>
								<td>매출 정보가 없습니다.</td>
							</tr>
						<%} else { %>
							<%for (Com1SaleDto tmp : listall) { %>
						<tr>
							<td><%= tmp.getStoreNum() %></td>
							<td><%= tmp.getSalesDate() %></td>
							<td><%= tmp.getDailySales() %></td>
						</tr>
						<%  }
						}%>			
					</tbody>
				</table>
			</div>
		</div>

		<div id="yearContent" class="tab-content p-3 bg-light rounded shadow-sm" style="display: block;">
			<div class="table-responsive">
				<table class="table table-hover text-center align-middle">
					<thead class="table-dark">
						<tr>
							<th>날짜 구분</th>
							<th>매출</th>
						</tr>
					</thead>
					<tbody>
						<% if ( listyear == null) { %>
							<tr>
								<td>연매출 정보가 없습니다.</td>
							</tr>
						<% } else { %>
					            <% for (Com1SaleDto tmp : listyear) { %>
						<tr>
							<td><%= tmp.getSyear() %></td>
							<td><%= tmp.getYearlySales() %></td>
						</tr>
						<%  } 
						}%>
					</tbody>
				</table>
			</div>
		</div>

	
		<div id="monthContent" class="tab-content p-3 bg-light rounded shadow-sm" style="display: block;">
			<div  class="table-responsive">
				<table class="table table-hover text-center align-middle">
					<thead class="table-dark">
						<tr>
							<th>날짜 구분</th>
							<th>매출</th>
						</tr>
					</thead>
					<tbody>
						<% if (listmonth == null) { %>
							<tr>
								<td>월매출 정보가 없습니다.</td>
							</tr>
						<%}else{ %>
							<%for (Com1SaleDto tmp: listmonth) { %>
								<tr>
									<td><%= tmp.getSmonth() %></td>
									<td><%= tmp.getMonthlySales() %></td>
								</tr>
						<%    }
						}%>
					</tbody>
				</table>
			</div>
		</div>
		
		
		<div id="storeContent" class="table-container tab-content p-3 bg-light rounded shadow-sm" style="display: block;">
			<div  class="table-responsive">
				<table class="table table-hover text-center align-middle">
					<thead class="table-dark">
						<tr>
							<th>날짜 구분</th>
							<th>매출</th>
						</tr>
					</thead>
					<tbody>
						<% if (listbystoreyearly.size()==0) { %>
							<tr>
								<td colspan="2">현매장 <%=storenum %>호점의 연매출 정보가 없습니다.</td>
							</tr>
						<%}else{ %>
							<%for (Com1SaleDto tmp: listbystoreyearly) { %>
								<tr>
									<td><%= tmp.getSyear() %></td>
									<td><%= tmp.getYearlySales() %></td>
								</tr>
						<%    }
						}%>
					</tbody>
				</table>
			</div>
			<div class="table-responsive">	
				<table class="table table-hover text-center align-middle">
					<thead class="table-dark">
						<tr>
							<th>날짜 구분</th>
							<th>매출</th>
						</tr>
					</thead>
					<tbody>
						<% if (listbystoremonthly.size()==0) { %>
							<tr>
								<td colspan="2">현매장 <%=storenum %>호점의 월매출 정보가 없습니다.</td>
							</tr>
						<%}else{ %>
							<%for (Com1SaleDto tmp: listbystoremonthly) { %>
								<tr>
									<td><%= tmp.getSmonth() %></td>
									<td><%= tmp.getMonthlySales() %></td>
								</tr>
						<%    }
						}%>
					</tbody>
				</table>
			</div>
			<div  class="table-responsive">	
				<table class="table table-hover text-center align-middle">
					<thead class="table-dark">
						<tr>
							<th>날짜 구분</th>
							<th>매출</th>
						</tr>
					</thead>
					
						<% if (listbystore.size()==0){ %>
							<tbody>
								<tr>
									<td colspan="2"> 현매장 <%=storenum %>호점의 매출 정보가 없습니다. </td>
								</tr>
							</tbody>
						<%}else{ %>
						<tbody>
							<%for (Com1SaleDto tmp: listbystore) { %>
								<tr>
									<td><%= tmp.getSdate() %></td>
									<td><%= tmp.getDailySales() %></td>
								</tr>
							<% }%>
						</tbody>
						<%}%>
				</table>
			</div>
		</div>
	</div>
</div>
	
<div class="table-container">
</div>
<div class="position-fixed bottom-0 w-100">
<jsp:include page="/include/footer.jsp" />
</div>
	
	<script>
	    function switchTab(tab) {
	        event.preventDefault();
	    	const tabs = ['all', 'year', 'month', 'store'];
	
	        tabs.forEach(t => {
	            document.getElementById(t + 'Content').style.display = 'none';
	            document.getElementById(t + 'Tab').classList.remove('active-tab');
	        });
	
	        document.getElementById(tab + 'Content').style.display = 'block';
	        document.getElementById(tab + 'Tab').classList.add('active-tab');
	    };
	
	    window.onload = function() {
	        const tabs = ['all', 'year', 'month', 'store'];
	        tabs.forEach(t => {
	            document.getElementById(t + 'Content').style.display = 'none';
	            document.getElementById(t + 'Tab').classList.remove('active-tab');
	        });

	        const urlParams = new URLSearchParams(window.location.search);
	        if (urlParams.has('storenum')) {
	            switchTab('store'); 
	        };
	    };

	</script>
</body>
</html>