<%@page import="test.dao.Com1SaleDao"%>
<%@page import="test.dto.Com1Dto"%>
<%@page import="test.dao.Com1Dao"%>
<%@page import="test.dto.Com1SaleDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    //현재 페이지 위치를 세션 영역에 저장 (관리자 전용 네비바에 활성 상태 표시 위함)
	session.setAttribute("current_page", "salemanage");
	//로그인 상태 표시 : 세션 영역에서 접속 계정 정보 가져오기
	String comname = (String)session.getAttribute("comname");
    String ename = (String)session.getAttribute("ename");
	//SaleDao의 getList를 사용해서 saledao 리스트 생성
	List<Com1SaleDto> list = Com1SaleDao.getInstance().getListAll();
	List<Integer> storenumlist = Com1Dao.getInstance().getStoreNumList();
	
	int storenum=-1;
	List<Com1SaleDto> listbystore=null;
	List<Com1SaleDto> listmonthlybystore=null;
	List<Com1SaleDto> listyearlybystore=null;
	String strStorenum=request.getParameter("storenum");
	if(strStorenum!=null&&!strStorenum.isEmpty()){
		storenum = Integer.parseInt(strStorenum);
		listbystore = Com1SaleDao.getInstance().getListbyStore(storenum);
		listmonthlybystore = Com1SaleDao.getInstance().getListMonthlybyStore(storenum);
		listyearlybystore = Com1SaleDao.getInstance().getListYearlybyStore(storenum);
	};
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

</style>
</head>
<body>
	<div>
		<form action="viewsale.jsp" id="storeselect">
			<label for="storenum">매장 선택</label> <select name="storenum"
				id="storenum">
				<%for (Integer tmp : storenumlist){ %>
					<option value="<%=tmp %>" <%=storenum==tmp ? "selected" : "" %>>매장 <%=tmp %></option>
				<%} %>
			</select>
			<button type="submit">조회</button>
		</form>

	</div>
	<div>
		<table id="sales">
			<thead>
				<tr>
					<th></th>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%for (Com1SaleDto tmp : listbystore) { %>
				<tr>
					<td><%=tmp.getStoreNum() %></td>
					<td><%=tmp.getSalesDate() %></td>
					<td><%=tmp.getDailySales() %></td>
				</tr>
				<%}%>
			</tbody>
		</table>
		<table id="sales">
			<thead>
				<tr>
					<th></th>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%for (Com1SaleDto tmp : listyearlybystore) { %>
				<tr>
					<td><%=tmp.getYear() %></td>
					<td><%=tmp.getYearlySales() %></td>
				</tr>
				<%}%>
			</tbody>
		</table>
		<table id="sales">
			<thead>
				<tr>
					<th></th>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%for (Com1SaleDto tmp : listmonthlybystore) { %>
				<tr>
					<td><%=tmp.getYear() %></td>
					<td><%=tmp.getMonth() %></td>	
					<td><%=tmp.getMonthlySales() %></td>
				</tr>
				<%}%>
			</tbody>
		</table>
	</div>

<script>
		//조건에 따라 삽입할 thead요소와 tbody요소
		const thead = document.createElement('thead');
	    const theadtr = document.createElement('tr');
		
		const tbody = document.createElement('tbody');
		const tbodytr = document.createElement('tr');
		
		// 폼이 제출될 때 처리할 이벤트 리스너 추가
    	document.querySelector("#storeselect").addEventListener('submit', function(event) {
        event.preventDefault(); // 폼이 실제로 제출되는 것을 막음

        // 선택된 매장 번호 가져오기
        const selectedStoreNum = document.querySelector("#storenum").value;
        console.log("선택된 매장 번호:", selectedStoreNum);

        // 여기에 추가 작업을 추가할 수 있습니다.
        // 예를 들어, 선택된 매장 번호에 따른 추가 로직을 구현할 수 있습니다.

        // 선택된 값이 있을 경우, 폼을 제출
        if (selectedStoreNum) {
        	document.querySelector("#storeselect").submit();
        	// 매장 번호가 선택되었으면 폼을 제출
        	
        	document.querySelector("#sales")
        } else {
            alert("매장을 선택해 주세요.");
        }
    });
</script>
</body>
</html>