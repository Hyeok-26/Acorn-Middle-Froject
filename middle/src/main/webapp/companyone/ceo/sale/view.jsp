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

	if(strStoreNum!=null&&!strStoreNum.isEmpty()){
		storenum = Integer.parseInt(strStoreNum);
		listbystore = saledao.getListbyStore(storenum);
		listbystoremonthly = saledao.getListMonthlybyStore(storenum);
		listbystoreyearly= saledao.getListYearlybyStore(storenum);
	}

	
	//request에 정보 담아두기 
	request.setAttribute("listall", listall);
	request.setAttribute("listsalemonth", listsalemonth);
	request.setAttribute("listsaleyear", listsaleyear);
	request.setAttribute("listbystore", listbystore);
	request.setAttribute("listbystoremonthly", listbystoremonthly);
	request.setAttribute("listbystoreyearly", listbystoreyearly);
	
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
		<div>
			<ul class="nav nav-tabs">
				<li class="nav-item" id="all">
					<a class="nav-link" aria-current="page" href="#" >매출 전체</a>
				</li><%--매장상관없이 전체 일매출 --%>
				<li class="nav-item" id="allyear">
					<a class="nav-link" aria-current="page"href="#" >연매출</a>
				</li><%--매장상관없이 연매출: 년/월/일, 매출 --%>
				<li class="nav-item" "id=allmonth">
					<a class="nav-link" aria-current="page" href="#">월매출</a>
				</li><%--매장상관없이 월매출 : 년/월/일,매출 --%>

				<li class="dropdown">
					<a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" role="button" aria-expanded="false"> 매장별 매출 </a>
					<ul class="dropdown-menu">
						<c:forEach var="num" items="${storeList}">
							<li class="nav-item" id = "store"><a class="dropdown-item"	href="#"> ${num} </a></li>
						</c:forEach>
					</ul></li>
			</ul>
		</div>


		<!-- 전체매출 탭 -->
		<div id = "all" class="p-3 bg-light rounded shadow-sm" style="">
			<div class="table-responsive">
				<table class="table table-hover text-center align-middle">
					<thead class="table-dark">
						<c:choose>
							<c:when test="${empty listall}">
								<p>출력할 전체 매출 데이터가 없습니다.</p>
							</c:when>
							<c:otherwise>
									<tr>
										<th>호점</th>
										<th>날짜 구분</th>
										<th>매출</th>
									</tr>
									<c:forEach var="tmp" items="${listall}">
										<tr>
											<td>${tmp.storenum}</td>
											<td>${tmp.salesDate}</td>
											<td>${tmp.dailySales}</td>
										</tr>
									</c:forEach>
							</c:otherwise>
						</c:choose>
				</table>		
			</div>
		</div>
		
		<%-- 연매출 탭 --%>
		<div id = "allyear" class="p-3 bg-light rounded shadow-sm" style="">
			<div class="table-responsive">
				<table class="table table-hover text-center align-middle">
					<thead class="table-dark">
						<c:choose>
							<c:when test="${empty listsaleyear}">
								<p>출력할 연매출 데이터가 없습니다.</p>
							</c:when>
							<c:otherwise>
									<tr>
										<th>날짜 구분</th>
										<th>매출</th>
									</tr>
									<c:forEach var="tmp" items="${listsaleyear}">
										<tr>
											<td>${tmp.year}</td>
											<td>${tmp.yearlySales}</td>

										</tr>
									</c:forEach>
								
							</c:otherwise>
						</c:choose>
				</table>
			</div>
		</div>
		
		<%-- 월매출 탭--%>
		<div id = "allmonth" class="p-3 bg-light rounded shadow-sm" style="">
			<div class="table-responsive">
				<table class="table table-hover text-center align-middle">
					<thead class="table-dark">
						<c:choose>
							<c:when test="${empty listsalemonth}">
								<p>출력할 월매출 데이터가 없습니다.</p>
							</c:when>
							<c:otherwise>
									<tr>
										<th>날짜 구분</th>
										<th>매출</th>
									</tr>
									<c:forEach var="tmp" items="${listsalemonth}">
										<tr>
											<td>${tmp.month}</td>
											<td>${tmp.monthlySales}</td>

										</tr>
									</c:forEach>
			
							</c:otherwise>
						</c:choose>
					</table>
			</div>
		</div>
		
		
		
		<%-- 매장별 조회 --%>
		<div id = "store" class="p-3 bg-light rounded shadow-sm"  style="">
			<div class="table-responsive">
				<c:choose>
					<c:when test="${empty listbystoreyearly}">
						<p>현매장 ${storenum} 호점의 연매출 정보가 없습니다.</p>
					</c:when>
					<c:otherwise>
						<table class="table table-hover text-center align-middle">
							<thead>
								<tr>
									<th>날짜 구분</th>
									<th>매출</th>
								</tr>
							</thead>
							<c:forEach var="tmp" items="${listbystoreyearly}">
								<tr>
									<td>${tmp.year}</td>
									<td>${tmp.yearlySales}</td>
								</tr>
							</c:forEach>
						</table>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="table-responsive">
				<c:choose>
					<c:when test="${empty listbystoremonthly}">
						<p>현매장 ${storenum} 호점의 월매출 정보가 없습니다.</p>
					</c:when>
					<c:otherwise>
						<table class="table table-hover text-center align-middle">
							<thead>
								<tr>
									<th>날짜 구분</th>
									<th>매출</th>
								</tr>
							</thead>
							<c:forEach var="tmp" items="${listbystoremonthly}">
								<tr>
									<td>${tmp.month}</td>
									<td>${tmp.monthlySales}</td>
								</tr>
							</c:forEach>
						</table>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="table-responsive">
				<c:choose>
					<c:when test="${empty listbystore}">
						<p>현매장 ${storenum} 호점의 매출 정보가 없습니다.</p>
					</c:when>
					<c:otherwise>
						<table class="table table-hover text-center align-middle">
							<thead>
								<tr>
									<th>날짜 구분</th>
									<th>매출</th>
								</tr>
							</thead>
							<c:forEach var="tmp" items="${listbystore}">
								<tr>
									<td>${tmp.salesDate}</td>
									<td>${tmp.dailySales}</td>
								</tr>
							</c:forEach>
						</table>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>



	<!-- 푸터 -->
	<div class="position-fixed bottom-0 w-100">
		<jsp:include page="/include/footer.jsp" />
	</div>
	
</body>
</html>