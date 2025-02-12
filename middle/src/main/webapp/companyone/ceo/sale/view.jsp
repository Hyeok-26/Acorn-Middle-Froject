<%@page import="test.dto.Com1Dto"%>
<%@page import="test.dao.Com1SaleDao"%>
<%@page import="test.dao.Com1Dao"%>
<%@page import="test.dto.Com1SaleDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<%
    //현재 페이지 위치를 세션 영역에 저장 (관리자 전용 네비바에 활성 상태 표시 위함)
	session.setAttribute("current_page", "view");
	//로그인 상태 표시 : 세션 영역에서 접속 계정 정보 가져오기
	Com1SaleDao saledao = Com1SaleDao.getInstance();
	List<Integer> storenums = Com1Dao.getInstance().getStoreNumList();
		
	List<Com1SaleDto> listall= saledao.getListAll();
	List<Com1SaleDto> listmonth = saledao.getListSalebyMonth();
	List<Com1SaleDto> listyear = saledao.getListSalebyYear();
	List<Com1SaleDto> listbystore = new ArrayList<>();
	List<Com1SaleDto> listbystoremonthly = new ArrayList<>();
	List<Com1SaleDto> listbystoreyearly = new ArrayList<>();
	
	String strStoreNum=request.getParameter("storenum");
	if(strStoreNum!=null&&!strStoreNum.isEmpty()){
		storenum = Integer.parseInt(strStoreNum);
		listbystore = saledao.getListbyStore(storenum);
		listbystoremonthly = saledao.getListMonthlybyStore(storenum);
		listbystoreyearly= saledao.getListYearlybyStore(storenum);
	};
	request.setAttribute("storenum", storenum);
	
	
	/* String storecall=request.getParameter("storecall");
	if(storecall!=null&&storecall.isEmpty()){
		Com1Dto dto = new Com1Dto();
		Com1Dao.getInstance().insert(storecall);
	};
	request.setAttribute("storecall",storecall); */
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
</head>
<body  class="d-flex flex-column min-vh-100 bg-light">
	<%-- 관리자 페이지 전용 네비바 --%>
	<jsp:include page="/include/ceoNav.jsp"></jsp:include>
	<div class="main flex-grow-1">  
	
	
<!-- 본문 -->
<div class="contents text-center mt-3 mx-auto" style="width: 900px;">
	
	<!-- 조회조건 -->
	<div class="nav nav-tabs">
		<div>
			<button class="tab-button nav-item nav-link" id="allTab" onclick="switchTab('all')">전체 매출</button>
		</div>
		<div>
			<button class="tab-button nav-item nav-link" id="yearTab" onclick="switchTab('year')">전체 연매출</button>
		</div>
		<div>
			<button class="tab-button nav-item nav-link" id="monthTab" onclick="switchTab('month')">전체 월매출</button>
		</div>
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
			
			<!-- 매장 추가 버튼 -->
			<div class="ms-auto p-2">
				<button class="btn btn-primary" id="add-store" data-bs-toggle="modal" data-bs-target="#showModal">매장 추가</button>
			</div>
			
			<!-- 매장 추가 버튼을 누르면 나오는 모달 창 -->
			<div class="modal fade" id="showModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="showModalLabel" aria-hidden="true">
				<div class="modal-dialog">
				  <div class="modal-content">
				  
				  	<!-- 모달창 헤더 -->
				    <div class="modal-header">
				      <h1 class="modal-title fs-5" id="showModalLabel">매장 추가</h1>
				      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				    </div>
				    
				    <!-- 모달창 바디 -->
				    <div class="modal-body ">
				    	
				    	<!-- 데이터 조회 -->
					
				    	<form action="addStore.jsp" method="POST" id="addStoreForm" >
				    		<div class="mb-3 row" >
				    			<div class="col-3">매장 번호</div>
				    			<div class="col-9"><p style="text-align:left;">매장 번호는 자동으로 부여됩니다.</p></div>
				    		</div>
				    		<div class="mb-3 row" >
				    			<div class="col-3">
				    				<label for="storecall" class="form-label">매장 연락처</label>
				    			</div>
				    			<div class="col-6">
					    			<input v-model="storecall" type="text" class="form-control" name="storecall" id="storecall" placeholder="매장 연락처를 입력하세요"
					    			:class="{'is-invalid': !isCallValid && isCallDirty, 'is-valid':isCallValid}" 
					    			@input="onInput" required>
					    			<div class="invalid-feedback">전화 번호 형식으로 입력하세요</div>
				    			</div>
			      				<div class="col-3">
			      					<button class="btn btn-primary" type="submit" :disabled="!isCallValid" @click="addStore">추가</button>
			      				</div>
					   		</div>
					   </form>
					   	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
						<script>
							new Vue({
								el:"#addStoreForm",
								data:{
									storecall: "",  
						            isCallValid:false,
						            isCallDirty:false
						        },
								methods:{
									onInput(){
										this.isCallDirty = true;
										const reg_call=/^0\d{1,2}(-|\))\d{3,4}-\d{4}$/;
										this.isCallValid = reg_call.test(this.storecall);	
										console.log(this.isCallValid);
									},
									addStore(){
										
										// 폼 입력이 제대로 이루어 졌는지 확인
											//const storecall = this.storecall;
											
											fetch("addStore.jsp",{
												method:"POST",
												headers:{"Content-Type":"application/x-www-form-urlencoded; charset=utf-8"},
												body: "storecall=" + encodeURIComponent(this.storecall)
											})
											.then(res => res.json())
											.then(data=>{
												console.log(data);
												if(data.isSuccess){
													alert("매장이 추가되었습니다");
												}else {
													alert("추가 실패. 개발자 확인 요망!");
												}
												location.href = "view.jsp";
											})
											.catch((err)=>{
												console.log(err);
											});
										}
								}
							});
						</script>

				    </div>
				  </div>
				</div>
			</div>
	</div>
	
	<div class="contents text-center mt-3 mx-auto" style="width: 900px;">
		<div id="allContent" class="table-container tab-content p-3 bg-light rounded shadow-sm" style="display: block;">
			<div class="table-responsive">
				<table class="table table-hover text-center align-middle">
					<thead class="table-dark">
						<tr>
							<th>호점</th>
							<th>날짜 구분</th>
							<th>일매출</th>
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
							<th>연매출</th>
						</tr>
					</thead>
					<tbody>
						<% if ( listyear==null) { %>
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
							<th>월매출</th>
						</tr>
					</thead>
					<tbody>
						<% if (listmonth==null) { %>
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
							<th>연매출</th>
						</tr>
					</thead>
					<tbody>
						<% if (listbystoreyearly.size()==0) { %>
							<tr>
								<td colspan="2">매장을 선택하세요!</td>
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
							<th>월매출</th>
						</tr>
					</thead>
					<tbody>
						<% if (listbystoremonthly.size()==0) { %>
							<tr>
								<td colspan="2">매장을 선택하세요!</td>
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
							<th>일매출</th>
						</tr>
					</thead>
					
						<% if (listbystore.size()==0){ %>
							<tbody>
								<tr>
									<td colspan="2">매장을 선택하세요!</td>
								</tr>
							</tbody>
						<%}else{ %>
						<tbody>
							<%for (Com1SaleDto tmp: listbystore) { %>
								<tr>
									<td><%= tmp.getSdate()%></td>
									<td><%= tmp.getDailySales()%></td>
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
	    }
	
	    window.onload = function() {
	        const tabs = ['all', 'year', 'month', 'store'];
	        tabs.forEach(t => {
	            document.getElementById(t + 'Content').style.display = 'none';
	            document.getElementById(t + 'Tab').classList.remove('active-tab');
	        });

	        const urlParams = new URLSearchParams(window.location.search);
	        if (urlParams.has('storenum')) {
	            switchTab('store'); 
	        }
	    };
	</script>
	<%@ include file="/include/footer.jsp" %>
</body>
</html>