<%@page import="java.util.List"%>
<%@page import="test.dto.Com1EmpLogDto"%>
<%@page import="test.dao.Com1EmpLogDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

int empno=(int)session.getAttribute("empno");

//Com1EmpLogDao dao=Com1EmpLogDao.getInstance();
List<Com1EmpLogDto> list=Com1EmpLogDao.getInstance().getList(empno);

String ename=(String)session.getAttribute("ename");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근태 기록 관리</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
<style>
	.container2 {
		max-width: 800px;
		margin: 40px auto;
		background-color: #fff;
		padding: 20px;
		border-radius: 8px;
		border: 1px solid black;
		box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	}
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
<jsp:include page="/include/empNav.jsp"></jsp:include>
	<div class="container2" id="logTable">
    	<h1><strong><%=ename %></strong> 님 월별 근태 기록</h1>
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
					<%for(Com1EmpLogDto tmp:list){ %>
						<tr>
							<td><%=tmp.getWorkingDate() %></td>
							<td><%=tmp.getCheckIn() %></td>
							<td><%=tmp.getCheckOut() %></td>
							<td><%=tmp.getWorkingHours() %></td>
							<td><%=tmp.getRemarks() %></td>
						</tr>
					<%} %>
				</tbody>
			</table>
        <br>   
        <a href="log.jsp?empno=<%=empno %>">출퇴근 기록 페이지로 돌아가기</a>   
	</div>
	<div class="position-fixed bottom-0 w-100">
  		<jsp:include page="/include/footer.jsp" />
  	</div>

</body>
</html>