<%@page import="test.dto.Com1SaleDto"%>
<%@page import="test.dao.Com1SaleDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<Com1SaleDto> listMonth = Com1SaleDao.getInstance().getListSalebyMonth();
	pageContext.setAttribute("listMonth",listMonth);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	div{ border:1px solid red; }
</style>
<!-- 페이지 로딩에 필요한 자원 로드 -->
<jsp:include page="/include/resource.jsp"></jsp:include>
<link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css" />
<script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>
</head>
<body>
	
	<!-- 정보 -->
	<div class="container">
		
		<div class="row" style="height">
			<div class="col-7">1 일자별 조회
				<div id="searchForDate">
					<label for="date">날짜 입력</label>
					<input type="date" id="date" name="date"/>
					<button type="button" id="searchForDateBtn">조회</button>
					<div id="resultDate">
						<table>
							<thead>
								<tr>
									<th>호점</th>
									<th>날짜</th>
									<th>총 매출</th>
								</tr>
							</thead>
							<tbody id="tbodyByResultDate">
							</tbody>
						</table>
					</div>
				</div>
			</div>
			
			<div class="col-5">
				<div class="row">2 월 별 조회
					<div id="chart_month"></div>
				</div>
				<div class="row">3 년 별 조회
					<div id="chart_year"></div>
				</div>	
			</div>
			
		</div>
	
	</div>
	
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
	<script>
		
		
		// 차트 생성
        const Chart = toastui.Chart;
        // 공통 옵션
        const commonOptions = {
            chart: { width: 700, height: 300 },
        };

        // 월 데이터 로드
        const monthData = {
            categories: [
            	<%
            		for(Com1SaleDto tmp: listMonth){
            			tmp.getSmonth();
            		}
            	%>
            	${listMonth}.forEach(item=>{
            		item.getSmonth();
            	}); 
            ],
            series: [
                {
	                name: 'Income',
	                data: [
	                	${listMonth}.forEach(item=>{
	                		item.monthlysales;
	                	});	
					]
                }
            ],
        };
        const monthChartEl = document.getElementById('chart_month');
        const monthChart = new toastui.Chart.columnChart({ el: monthChartEl, data: monthData, options: commonOptions });

        // 라인 차트 생성 및 렌더링
        const YearData = {
            categories: [
            '01/01/2020',
            '02/01/2020'
            ],
            series: [
                {
                name: 'Seoul',
                data: [-3.5, -1.1]
                }
            ],
        };
        const yearChartEl = document.getElementById('chart_year');
        const yearChart = new toastui.Chart.lineChart({ el: yearChartEl, data: YearData, options: commonOptions });


        
        
        
        
     	// 날짜로 조회 경우 
		$("#searchForDateBtn").on("click",()=>{
			const date = $("#date").val();
			
			// 날짜에 맞는 json 데이터 요청
			fetch("loadSales.jsp?date="+date)
			.then(res=>res.json())
			.then(data=>{
				console.log("받아온 데이터:" + data);
				
				// table 하위 요소 만들어서 데이터 넣어주기
				for(i=0; i<data.length; i++){
					$("#tbodyByResultDate").empty();
					$("<td>").text(data[i].storeNum).appendTo("#tbodyByResultDate");
					$("<td>").text(data[i].salesDate).appendTo("#tbodyByResultDate");
					$("<td>").text(data[i].dailySales).appendTo("#tbodyByResultDate");
				} 
			});
		});
	</script>
</body>
</html>