<%@page import="test.dto.Com1EmpLogDto"%>
<%@page import="test.dao.Com1EmpLogDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--

int empno=(int)session.getAttribute("empno");

Com1EmpLogDao dao=Com1EmpLogDao.getInstance();
Com1EmpLogDto dto=dao.getData(empno);

--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근태 기록 관리</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
<style>
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
        padding: 8px 12px;
        border: 1px solid #ddd;
        text-align: center;
    }
    th {
        background-color: #f2f2f2;
    }    

</style>
</head>
<body>
<div class="container" id="logTable">
           	<h1><strong>${empno }</strong> 님 월별 근태 기록</h1>
           		<table>
					<thead>
						<tr>
							<th>날짜</th>
							<th>출근 시간</th>
							<th>퇴근 시간</th>
							<th>근무 시간</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${workingDate }</td>
							<td>${checkIn }</td>
							<td>${checkOut }</td>
							<td>${workingHours }</td>
							<td>${remarks }</td>
						</tr>
					</tbody>
				</table>
           
        <a href="log.jsp">출퇴근 기록 페이지로 돌아가기</a>   
</div>
<jsp:include page="/include/footer.jsp" />
</body>
</html>