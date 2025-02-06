<%@page import="test.dao.Com1Dao"%>
<%@page import="test.dto.Com1Dto"%>
<%@page import="test.dao.Com1SaleDao"%>
<%@page import="test.dto.Com1SaleDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
    // 1. 현재 페이지 위치를 세션에 저장 (관리자 전용 네비바에서 현재 위치를 강조하는 용도)
	session.setAttribute("current_page", "emolyeeManageForm");

	// 2. 로그인 상태 확인: 세션에서 로그인한 사용자의 회사명(comname)과 이름(ename) 가져오기
	String comname = (String)session.getAttribute("comname");
    String ename = (String)session.getAttribute("ename");

    // 3. 매출 관련 DAO 객체 생성
	Com1SaleDao SaleDao = Com1SaleDao.getInstance();

    // 4. 전체 매장의 번호 목록 가져오기
	List<Integer> storenums = Com1Dao.getInstance().getStoreNumList();

    // 5. 전체 매출 내역 가져오기
	List<Com1SaleDto> listall = SaleDao.getListAll();
    
    // 6. 특정 매장의 매출 정보를 저장할 변수 초기화
	Com1Dao com1Dao = Com1Dao.getInstance();
	String storenumParam = request.getParameter("storenum"); 
   	int storenum = -1; 	
  	List<Com1SaleDto> storeList = null;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출 관리 페이지</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<jsp:include page="/include/resource.jsp"></jsp:include>

<style>
/* 탭 버튼 스타일 */
.tab-button {
	padding: 10px 20px;
	cursor: pointer;
	font-weight: bold;
	background-color: #f1f1f1;
	border: 1px solid #ddd;
	transition: background-color 0.3s ease;
	display: inline-block;
}

/* 활성화된 탭 스타일 */
.active-tab {
	background-color: #dcdcdc;
	border-bottom: 2px solid #999;
}

/* 탭 내용 스타일 */
.tab-content {
	padding: 20px;
	background-color: #fff;
	border-top: 1px solid #ddd;
	display: none;
}

/* 테이블 스타일 */
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

    <!-- 네비게이션 바 포함 -->
	<jsp:include page="/include/navbar.jsp"></jsp:include>

	<div class="container">
		<!-- 현재 로그인한 사용자 정보 출력 (추후 주석 해제 가능) -->
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

        <!-- 탭 메뉴 -->
		<div class="tab-button" id="allTab" onclick="switchTab('all')">전체 매출</div>
		<div class="tab-button" id="allyearTab" onclick="switchTab('allyear')">전체 연매출</div>
		<div class="tab-button" id="allmonthTab" onclick="switchTab('allmonth')">전체 월매출</div>
	
		<!-- 전체 매출 탭 -->
		<div id="allContent" class="tab-content" style="display: block;">
			<form action="storeReport.jsp" method="POST">
				<!-- 조회 옵션 -->
				<label> 
					<input type="radio" name="store" value="all">전체매출
				</label> 
				<label> 
				    <input type="radio" name="store" value="yearall">매장 전체 연매출
				</label> 
				<label> 
				    <input type="radio" name="store" value="monthall">매장 전체 월매출
				</label>
				<label> 
					<input type="radio" name="store" value="storeyear">매장별 연매출
				</label> 
				<label> 
					<input type="radio" name="store" value="storemonth">매장별 월매출
				</label>
				<button type="submit">조회</button>
			</form>

            <!-- 전체 매출 테이블 -->
			<table>
				<thead>
					<tr>
						<th>호점</th>
						<th>날짜</th>
						<th>매출</th>
					</tr>
				</thead>
				<tbody>
					<%
					int totalSales = 0;
					if (listall != null && !listall.isEmpty()) {
						for (Com1SaleDto tmp : listall) {
					%>
					<tr>
						<td><%=tmp.getStoreNum()%></td>
						<td><%=tmp.getSaleDate()%></td>
						<td><%=tmp.getDailySales()%></td>
					</tr>
					<%
					totalSales += tmp.getDailySales();
					}
					}
					%>
					<tr>
						<td>총합</td>
						<td><%=totalSales%></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

    <!-- 하단 푸터 포함 -->
	<%@ include file="/include/footer.jsp"%>

	<script>
		function switchTab(tab) {
		    // 1. 탭 목록을 배열로 정의 (탭 전환 시 모든 탭을 비활성화할 때 사용)
		    const tabs = ['all', 'allyear', 'allmonth'];
	
		    // 2. 모든 탭을 숨기고 비활성화
		    tabs.forEach(t => {
		        // 각 탭의 콘텐츠 영역을 숨김 (display: none;)
		        document.getElementById(t + 'Content').style.display = 'none';
	
		        // 각 탭의 활성화 상태를 제거 (active-tab 클래스 삭제)
		        document.getElementById(t + 'Tab').classList.remove('active-tab');
		    });
	
		    // 3. 클릭한 탭만 보이도록 설정
		    // 클릭한 탭의 콘텐츠를 표시 (display: block;)
		    document.getElementById(tab + 'Content').style.display = 'block';
	
		    // 클릭한 탭 버튼을 활성화 상태로 변경 (active-tab 클래스 추가)
		    document.getElementById(tab + 'Tab').classList.add('active-tab');
		}


	    // 페이지 로드 시 URL에서 특정 파라미터(storenum) 확인 후 자동으로 탭 변경
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
