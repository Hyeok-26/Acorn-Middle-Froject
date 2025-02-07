<%@page import="test.dao.Com1Dao"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@page import="java.util.List"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>
<%
	//현재 페이지 위치를 세션 영역에 저장 (관리자 전용 네비바에 활성 상태 표시 위함)
	session.setAttribute("current_page", "emolyeeManageForm");


	//로그인 상태 표시 : 세션 영역에서 접속 계정 정보 가져오기
	String comname = (String)session.getAttribute("comname");
	String ename = (String)session.getAttribute("ename");

	
	/*
	// 세션 영역에서 회사번호, 회사이름, 사원번호, 역할, 이름 을 가져옴
	int comid = (int)session.getAttribute("comid");
	String comname = (String)session.getAttribute("comname");
	int empno = (int)session.getAttribute("empno");
	String role = (String)session.getAttribute("role");
	String ename = (String)session.getAttribute("ename");
	*/
	
	// DB에서 직원, 점장, 관리자 리스트 정보 추출
	Com1EmpDao empDao = Com1EmpDao.getInstance();
	List<Com1EmpDto> employeeList = empDao.getList();
	List<Com1EmpDto> adminList = empDao.getListAdmin();
	List<Com1EmpDto> staffList = empDao.getListStaff();
	
	// DB에서 지점 리스트 정보 추출
	Com1Dao com1Dao = Com1Dao.getInstance();
	List<Integer> storeNumbers = com1Dao.getStoreNumList();

	// 요청에서 넘어온 지점 번호가 있는지 확인
	String storenumParam = request.getParameter("storenum");
    int storenum = -1;  
    List<Com1EmpDto> storeEmpList = null;

    // 요청에서 넘어온 지점번호가 있다면
    if (storenumParam != null && !storenumParam.isEmpty()) {
    	// 넘어온 지점 번호 사용
        storenum = Integer.parseInt(storenumParam);
    	// DB 그 지점번호에 속한 직원 정보 리스트 추출
        storeEmpList = empDao.getListByStoreNum(storenum); 
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 목록 페이지</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
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
<!-- <body class=" d-flex flex-column min-vh-100"> -->
<body>
	<div class="container">
		<%-- 관리자 페이지 전용 네비바: 관리자 페이지 이동을 쉽게 하기 위함 --%>
		<jsp:include page="/include/ceoNav.jsp"></jsp:include>
	
		<%-- 현재 접속 상태 표시 --%>
		<%--<div class="container">
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
		</div> --%>
		<div class="container">
		<p><%=comname %>의  <%=ename %>님 접속 중</p>
		</div>
		
		<%-- 정보 표시 --%>
		<div class="container flex-fill" style="width: 100%; margin-top: 50px;">
			<div class="tab-button" id="employeeTab" onclick="switchTab('employee')">전체 직원</div>
			<div class="tab-button" id="adminTab" onclick="switchTab('admin')">점장</div>
			<div class="tab-button" id="staffTab" onclick="switchTab('staff')">직원</div>
			<div class="tab-button" id="storeNumTab" onclick="switchTab('storeNum')">호점</div>
	
			<div id="employeeContent" class="tab-content" style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: block;">
				<h1>전체 직원</h1>
				<table>
					<thead>
						<tr>
							<th>호점</th>
							<th>사원번호</th>
							<th>이름</th>
							<th>직급</th>
							<th>전화번호</th>
							<th>이메일</th>
						</tr>
					</thead>
					<tbody>
						<% if (employeeList != null && !employeeList.isEmpty()) { 
					            for (Com1EmpDto emp : employeeList) { %>
						<tr>
							<td><%= emp.getStoreNum() %></td>
							<td><%= emp.getEmpNo() %></td>
							<td><%= emp.geteName() %></td>
							<td><%= emp.getRole() %></td>
							<td><%= emp.geteCall() %></td>
							<td><%= emp.getEmail() %></td>
						</tr>
						<%  } 
					           } else { %>
						<tr>
							<td colspan="11">등록된 직원 정보가 없습니다.</td>
						</tr>
						<% } %>
					</tbody>
				</table>
			</div>
	
			<div id="adminContent" class="tab-content"
				style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: block;">
				<h1>점장</h1>
				<table>
					<thead>
						<tr>
							<th>호점</th>
							<th>사원번호</th>
							<th>이름</th>
							<th>직급</th>
							<th>전화번호</th>
							<th>월급</th>
							<th>이메일</th>
						</tr>
					</thead>
					<tbody>
						<% if (adminList != null && !adminList.isEmpty()) { 
					            for (Com1EmpDto admin : adminList) { %>
						<tr>
							<td><%= admin.getStoreNum() %></td>
							<td><%= admin.getEmpNo() %></td>
							<td><%= admin.geteName() %></td>
							<td><%= admin.getRole() %></td>
							<td><%= admin.geteCall() %></td>
							<td><%= admin.getSal() %></td>
							<td><%= admin.getEmail() %></td>
						</tr>
						<%  } 
					           } else { %>
						<tr>
							<td colspan="11">등록된 관리자 정보가 없습니다.</td>
						</tr>
						<% } %>
					</tbody>
				</table>
			</div>
	
			<div id="staffContent" class="tab-content"
				style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: block;">
				<h1>직원</h1>
				<table>
					<thead>
						<tr>
							<th>호점</th>
							<th>사원번호</th>
							<th>이름</th>
							<th>직급</th>
							<th>전화번호</th>
							<th>월급</th>
							<th>시급</th>
							<th>이메일</th>
						</tr>
					</thead>
					<tbody>
						<% if (staffList != null && !staffList.isEmpty()) { 
				            for (Com1EmpDto staff : staffList) { %>
						<tr>
							<td><%= staff.getStoreNum() %></td>
							<td><%= staff.getEmpNo() %></td>
							<td><%= staff.geteName() %></td>
							<td><%= staff.getRole() %></td>
							<td><%= staff.geteCall() %></td>
							<td><%= staff.getSal() %></td>
							<td><%= staff.getHsal() %></td>
							<td><%= staff.getEmail() %></td>
						</tr>
						<%  } 
				           } else { %>
						<tr>
							<td colspan="11">등록된 관리자 정보가 없습니다.</td>
						</tr>
						<% } %>
					</tbody>
				</table>
			</div>
	
			<div id="storeNumContent" class="tab-content"
				style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: block;">
				<h2>지점별 직원 목록</h2>
				<form method="get" id="storeForm">
					<label for="storenum">지점 선택: </label> <select name="storenum"
						id="storenum"
						onchange="switchTab('storeNum'); document.getElementById('storeForm').submit();">
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
				<h3><%= storenum %>호점 직원 목록
				</h3>
				<table border="1" cellspacing="0" cellpadding="8">
					<thead>
						<tr>
							<th>호점</th>
							<th>사원번호</th>
							<th>이름</th>
							<th>직급</th>
							<th>전화번호</th>
							<th>월급</th>
							<th>시급</th>
							<th>이메일</th>
						</tr>
					</thead>
					<tbody>
						<% if (storeEmpList != null && !storeEmpList.isEmpty()) { 
				                for (Com1EmpDto emp : storeEmpList) { %>
						<tr>
							<%for(int num: storeNumbers){ %>
							<td><%=num %></td>
							<%} %>
							<td><%= emp.getEmpNo() %></td>
							<td><%= emp.geteName() %></td>
							<td><%= emp.getRole() %></td>
							<td><%= emp.geteCall() %></td>
							<td><%= emp.getSal() %></td>
							<td><%= emp.getHsal() %></td>
							<td><%= emp.getEmail() %></td>
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
	</div>
	
	
	
		
	
	

	

	<%@ include file="/include/footer.jsp"%>

	<script>
	    function switchTab(tab) {
	        const tabs = ['employee', 'admin', 'staff', 'storeNum'];
	
	        tabs.forEach(t => {
	            document.getElementById(t + 'Content').style.display = 'none';
	            document.getElementById(t + 'Tab').classList.remove('active-tab');
	        });
	
	        document.getElementById(tab + 'Content').style.display = 'block';
	        document.getElementById(tab + 'Tab').classList.add('active-tab');
	    }
	
	    window.onload = function() {
	        const tabs = ['employee', 'admin', 'staff', 'storeNum'];
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