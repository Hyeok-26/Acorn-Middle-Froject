<%@page import="java.util.List"%>
<%@page import="test.dto.Com1EmpLogDto"%>
<%@page import="test.dao.Com1EmpLogDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>	
<%
	session.setAttribute("current_page", "log");
	//int empno=(int)session.getAttribute("empno");
	
	//Com1EmpLogDao dao=Com1EmpLogDao.getInstance();
	List<Com1EmpLogDto> list=Com1EmpLogDao.getInstance().getList(empno);
	
	//String ename=(String)session.getAttribute("ename");
	
	Com1EmpLogDto dto = new Com1EmpLogDto();
	//한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT=10;
	//하단 페이지를 몇개씩 표시할 것인지
	final int PAGE_DISPLAY_COUNT=5;
	
	//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
	int pageNum=1;
	
	//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
	String strPageNum=request.getParameter("pageNum");
	//만일 페이지 번호가 파라미터로 넘어 온다면
	if(strPageNum != null){
		//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
		pageNum=Integer.parseInt(strPageNum);
	}
	
	//보여줄 페이지의 시작 ROWNUM
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지의 끝 ROWNUM
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
		//하단 시작 페이지 번호 
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//하단 끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		//전체 글의 갯수
		int totalRow=Com1EmpLogDao.getInstance().getCount(dto);
		//전체 페이지의 갯수 구하기
		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		if(endPageNum > totalPageCount){
			endPageNum=totalPageCount; //보정해 준다. 
		}	
		
		// startRowNum 과 endRowNum 을 PostDto 객체에 담아서
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		//보여줄 페이지에 해당하는 글 목록을 얻어온다.
		List<Com1EmpLogDto> lists=Com1EmpLogDao.getInstance().getList(empno);
		
		/*
			jsp 페이지에서 응답에 필요한 데이터를 el 에서 활용할수 있도록
			request 객체에 특정 키값으로 담는다.
		*/
		request.setAttribute("list", lists);
		request.setAttribute("startPageNum", startPageNum);
		request.setAttribute("endPageNum", endPageNum);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("totalRow", totalRow);
		request.setAttribute("dto", dto);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근태 기록 관리</title>
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
        background-color: #c8c8c8;
    }    

</style>
</head>
<body>
<jsp:include page="/include/empNav.jsp"></jsp:include>
	<div class="container2" id="logTable">
    	<h1><strong><%=ename %></strong> 님 날짜별 근태 기록</h1>
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
        <nav class="d-flex justify-content-center mt-2">
			<ul class="pagination">
				<!-- Prev 버튼 -->
				<c:if test="${startPageNum ne 1}">
					<li class="page-item">
						<a class="page-link" href="logTable.jsp?pageNum=${startPageNum - 1}">Prev</a>
					</li>
				</c:if>
				<!-- 페이지 번호 -->
				<c:forEach begin="${startPageNum}" end="${endPageNum}" var="i">
					<li class="page-item ${i == pageNum ? 'active' : ''}">
						<a class="page-link" href="logTable.jsp?pageNum=${i}">${i}</a>
					</li>
				</c:forEach>
				<!-- Next 버튼 -->
				<c:if test="${endPageNum < totalPageCount}">
					<li class="page-item">
						<a class="page-link" href="logTable.jsp?pageNum=${endPageNum + 1}">Next</a>
					</li>
				</c:if>
			</ul>		
		</nav>   
        <a href="log.jsp?empno=<%=empno %>">출퇴근 페이지로 돌아가기</a>   
	</div>
	<div class="position-fixed bottom-0 w-100">
  		<jsp:include page="/include/footer.jsp" />
  	</div>

</body>
</html>