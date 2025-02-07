<%@page import="java.util.ArrayList"%>
<%@page import="test.dao.Com1Dao"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@page import="java.util.List"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	//현재 페이지 위치를 세션 영역에 저장 (관리자 전용 네비바에 활성 상태 표시 위함)
	session.setAttribute("current_page", "manageForm");



	//로그인 상태 표시 : 세션 영역에서 접속 계정 정보 가져오기
	String comname = (String)session.getAttribute("comname");
	String ename = (String)session.getAttribute("ename");

	
	// DB 에서 조회할 때 넘겨줄 객체
	Com1EmpDto dto = new Com1EmpDto();
	
	
	// 보여줄 조건 기본 값
	String condition = "ALL";
	int storeNum = 1;
	
	
	// 보여줄 조건을 파라미터로 받기
	String strCondition = request.getParameter("condition"); 	// ALL | ADMIN | STAFF | STORE
	String strStoreNum = request.getParameter("storenum"); 		// 1 | 2 | 3 ...
	if(strCondition != null) condition = strCondition;
	if(strStoreNum != null) storeNum = Integer.parseInt(strStoreNum);
	dto.setCondition(condition);
	dto.setStoreNum(storeNum);
	
	
	
	// 페이징 처리
	final int PAGE_ROW_COUNT = 10;
	final int PAGE_DISPLAY_COUNT = 3;
	
	// 페이지 값을 파라미터로 받기
	int pageNum = 1;
	String strPageNum = request.getParameter("pageNum");
	if(strPageNum != null) pageNum = Integer.parseInt(strPageNum);
	
	// 보여줄 row 값
	int startRowNum = (pageNum-1)*PAGE_ROW_COUNT + 1;
	int endRowNum = PAGE_ROW_COUNT*pageNum;
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	// 하단 페이징 값
	int startPageNum = ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT + 1;
	int endPageNum = startPageNum+PAGE_DISPLAY_COUNT - 1;
	
	// 페이지 수 계산
	int totalRow = Com1EmpDao.getInstance().getCount(dto);
	int totalPageCount =  (int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	if(endRowNum > totalPageCount) endPageNum = totalPageCount;
	

	// DB 에서 정보 추출
	List<Com1EmpDto> list = Com1EmpDao.getInstance().getList2(dto);
	pageContext.setAttribute("list", list);
	
	
	// 몇 호점 리스트 정보 가져오기
	List<Integer> storeList = Com1Dao.getInstance().getStoreNumList();
	pageContext.setAttribute("storeList", storeList);
	
	
	// request 영역에 필요한 정보 저장
	request.setAttribute("startPageNum", startPageNum);
	request.setAttribute("endPageNum", endPageNum);
	request.setAttribute("totalPageCount", totalPageCount);
	request.setAttribute("pageNum", pageNum);
	request.setAttribute("totalRow", totalRow);
	request.setAttribute("condition", condition);
	request.setAttribute("storenum", storeNum);
	
	
	// 디버깅용..
	System.out.println("pageNum: "+pageNum);
	System.out.println("condition: "+condition);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 목록 페이지</title>
<style>
	/* div{ border:1px solid red; } */
</style>
<!-- 페이지 로딩에 필요한 자원 -->
<jsp:include page="/include/resource.jsp"></jsp:include>
</head>
<body>
	<%-- 관리자 페이지 전용 네비바 --%>
	<jsp:include page="/include/ceoNav.jsp"></jsp:include>
	
	<!-- 현재 접속 상태 표시 -->
	<div class="container">
		<p><%=comname %>의  <%=ename %>님 접속 중</p>
	</div>
	
	
	<!-- 본문 -->
	<div class="contents text-center mt-3 mx-auto" style="width:900px;">
		<h4>근무 직원 현황</h4>
		
		<!-- 조회 조건 -->
		<div>
		<ul class="nav nav-tabs">
		  	<li class="nav-item">
		  		<a class="nav-link" aria-current="page" href="manageForm.jsp?condition=ALL&pageNum=${pageNum}">전체 직원</a>
		  	</li>
		  	<li class="nav-item">
		  		<a class="nav-link" aria-current="page" href="manageForm.jsp?condition=ADMIN&pageNum=${pageNum}">점장</a>
		  	</li>
		  	<li class="nav-item">
		  		<a class="nav-link" aria-current="page" href="manageForm.jsp?condition=STAFF&pageNum=${pageNum}">직원</a>
		  	</li>
		  	
		  	<li class="nav-item dropdown">
		  		<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">몇 호점 별 직원</a>
		  		<ul class="dropdown-menu">
		  			<c:forEach var="num" items="${storeList }">
		  				<li><a class="dropdown-item" href="manageForm.jsp?condition=STORE&storenum=${num}">${num}</a></li>
		  			</c:forEach>
			    </ul>
		  	</li>
		</ul>
		</div>
		
		
		<!-- 조회 결과 -->
		<div class="tab-content p-3 bg-light rounded shadow-sm" style="height:500px" id="myTabContent">
			<div class="table-responsive">
				<table class="table table-hover text-center align-middle">
					<thead class="table-dark">
						<tr>
							<th>호점</th>
							<th>사원 번호</th>
							<th>이름</th>
							<th>직급</th>
							<th>전화번호</th>
							<th>월급</th>
							<th>입사일</th>
							<th>이메일</th>
						</tr>
					</thead>
					<tbody>
					<c:choose>
						<%-- 데이터가 없는 경우 --%>
						<c:when test="${empty list}">
							</tbody>
							</table>
							<div class=" justify-content-center align-items-center vh-100">
							  <div class="p-3 bg-light">직원 정보가 없습니다!</div>
							</div>
						</c:when>
						<%-- 데이터가 있는 경우 --%>
						<c:otherwise>
							<c:forEach var="tmp" items="${list}">
								<c:choose>
									<%-- 알바 경우 --%>
									<c:when test="${tmp.sal eq 0}">
										<tr>
											<td>${tmp.storeNum }</td>
											<td>${tmp.empNo }</td>
											<td>${tmp.eName }</td>
											<td>${tmp.role }</td>
											<td>${tmp.eCall }</td>
											<td>${tmp.hsal * tmp.worktime}</td>
											<td>${tmp.hiredate }</td>
											<td style="width:300px">${tmp.email }</td>
										</tr>
									</c:when>
									<%-- 직원 경우 --%>
									<c:otherwise>
										<tr>
											<td>${tmp.storeNum }</td>
											<td>${tmp.empNo }</td>
											<td>${tmp.eName }</td>
											<td>${tmp.role }</td>
											<td>${tmp.eCall }</td>
											<td>${tmp.sal }</td>
											<td>${tmp.hiredate }</td>
											<td style="width:300px">${tmp.email }</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							</tbody>
							</table>
						</c:otherwise>
					</c:choose>
			</div>
		</div>
		
		
		
		
		<%-- 하단 페이징 버튼 --%>
		<div class="mt-3 d-flex justify-content-center">
			<nav>
				<ul class="pagination mx-auto">
					<!-- Prev 버튼 -->
					<c:if test="${startPageNum ne 1}">
						<li class="page-item">
							<a class="page-link" href="manageForm.jsp?pageNum=${startPageNum - 1}&condition=${condition}">Prev</a>
						</li>
					</c:if>
					<!-- 페이지 번호 -->
					<c:forEach begin="${startPageNum}" end="${endPageNum}" var="i">
						<li class="page-item ${i == pageNum ? 'active' : ''}">
							<a class="page-link" href="manageForm.jsp?pageNum=${i}&condition=${condition}">${i}</a>
						</li>
					</c:forEach>
					<!-- Next 버튼 -->
					<c:if test="${endPageNum < totalPageCount}">
						<li class="page-item">
							<a class="page-link" href="manageForm.jsp?pageNum=${endPageNum + 1}&condition=${condition}">Next</a>
						</li>
					</c:if>
				</ul>		
			</nav>
		</div>
	</div>
			
			
	
	
			
			
		
	<!-- 푸터 -->
	<div class="position-fixed bottom-0 w-100">
  	<jsp:include page="/include/footer.jsp" />
  	</div>
</body>
</html>