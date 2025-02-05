<%@page import="test.dao.Com1Dao"%>
<%@page import="test.dto.Com1SaleDto"%>
<%@page import="test.dao.Com1SaleDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

	int comid = (int)session.getAttribute("comid");
	String comname = (String)session.getAttribute("comname");
	int empno = (int)session.getAttribute("empno");
	String role = (String)session.getAttribute("role");
	String ename = (String)session.getAttribute("ename");
	
	Com1SaleDao SaleDao = Com1SaleDao.getInstance();
	Com1Dao com1Dao = Com1Dao.getInstance();
	
	List<Integer> storeNumbers = com1Dao.getStoreNumList();

	String storenumParam = request.getParameter("storenum");
    int storenum = -1;  
	List<Com1SaleDto> SaleList = SaleDao.getList();
    List<Com1SaleDto> storeEmpList = null;

    if (storenumParam != null && !storenumParam.isEmpty()) {
        storenum = Integer.parseInt(storenumParam);
        storeEmpList = SaleDao.getList(); 
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
<style>
.sidebar-item {
	text-align: center;
	padding: 10px;
	cursor: pointer;
}

.sidebar-item:hover {
	background-color: lightgrey; /* 배경색 변경 */
	color: white; /* 텍스트 색상 변경 */
}
/* 테이블 헤더 고정 */
th {
	position: sticky;
	top: 0;
	background-color: #f1f1f1; /* 배경색 고정 */
	z-index: 1; /* 헤더가 다른 콘텐츠 위에 오도록 설정 */
}

/* 테이블 스타일 */
table {
	width: 100%;
	border-collapse: collapse;
	border: 1px solid #ccc;
}

th, td {
	padding: 8px;
	border: 1px solid #ddd;
}
</style>
</head>
<body>
	<div class="container">
		<p>
			회사코드 :
			<%=comid %>
			회사번호 :
			<%=comname %>
			사원번호 :
			<%=empno %>
			역할 :
			<%=role %>
			이름 :
			<%=ename %>
		</p>
	</div>
	<div class="container flex-fill" style="width: 100%; margin-top: 50px;">
		<div class="tab-button" id="employeeTab" onclick="switchTab('employee')">전체 직원</div>
		<div class="tab-button" id="adminTab" onclick="switchTab('admin')">점장</div>
		<div class="tab-button" id="staffTab" onclick="switchTab('staff')">직원</div>
		<div class="tab-button" id="storeNumTab"onclick="switchTab('storeNum')">호점</div>


		<div id="storeNumContent" class="tab-content" style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: block;">
			
			<form method="get" id="storeForm">
				<label for="storenum">지점 선택: </label> 
				<select name="storenum"	id="storenum"
					onchange="document.getElementById('storeForm').submit();">
					<option value="">-- 지점을 선택하세요 --</option>
					<% for (Integer storeNum : storeNumbers) { %>
					<option value="<%= storeNum %>"
						<%= (storeNum == storenum) ? "selected" : "" %>>
						<%= storeNum %>호점
					</option>
					<% } %>
				</select>
			</form>

			<br />

			<% if (storenum != -1) { %>
			<h3><%= storenum %>호점 매출 목록
			</h3>
			<table border="1" cellspacing="0" cellpadding="8">
				<thead>
					<tr>
						<th>월</th>
						<th>월 매출</th>
						<th>작성일자</th>
					</tr>
				</thead>
				<tbody>
					<% if (storeEmpList != null && !storeEmpList.isEmpty()) { 
			                for (Com1SaleDto tmp : storeEmpList) { %>
					<tr>
						<%for(int num: storeNumbers){ %>
						<td><%=num %></td>
						<%} %>
						<td><%=tmp.getSalemonth() %></td>
						<td><%=tmp.getMonthlysal() %></td>
						<td><%=tmp.getCreated_at() %></td>
					</tr>
					<%  } 
			               } else { %>
					<tr>
						<td colspan="11">해당 지점에 등록된 직원 정보가 없습니다.</td>
					</tr>
					<% } %>
					<% } %>
				</tbody>
			</table>
		</div>
	</div>

	<jsp:include page="/include/footer.jsp" />
	<script>
	    // 시작 날짜와 종료 날짜를 계산하는 함수
	    function updateEndDate() {
	        const startDate = document.getElementById("startDate").value;
	        const endDateInput = document.getElementById("endDate");
	
	        if (!startDate) return;
	
	        const start = new Date(startDate);
	
	        // 종료 날짜를 오늘로 기본 설정
	        let endDate = new Date(start);
	
	        // 종료 날짜 초기화
	        endDateInput.value = "";
	
	        // 자동으로 계산된 종료 날짜를 갱신
	        document.getElementById("today").checked = false;
	        document.getElementById("week").checked = false;
	        document.getElementById("month").checked = false;
	    }
	
	    // 체크박스를 클릭했을 때 종료 날짜를 설정하는 함수
	    function setEndDate(period) {
	        const startDate = document.getElementById("startDate").value;
	        const endDateInput = document.getElementById("endDate");
	
	        if (!startDate) return;
	
	        const start = new Date(startDate);
	        let endDate;
	
	        switch (period) {
	            case 'today':
	                // 당일은 시작 날짜와 동일
	                endDate = new Date(start);
	                break;
	            case 'week':
	                // 일주일 후 종료 날짜
	                endDate = new Date(start);
	                endDate.setDate(start.getDate() + 7);
	                break;
	            case 'month':
	                // 한 달 후 종료 날짜
	                endDate = new Date(start);
	                endDate.setMonth(start.getMonth() + 1);
	                break;
	            default:
	                return;
	        }
	
	        // 종료 날짜를 해당 날짜로 설정
	        endDateInput.value = endDate.toISOString().split('T')[0];
	
	        // 체크박스 상태 갱신
	        document.getElementById("today").checked = (period === 'today');
	        document.getElementById("week").checked = (period === 'week');
	        document.getElementById("month").checked = (period === 'month');
		}
	</script>
</body>
</html>