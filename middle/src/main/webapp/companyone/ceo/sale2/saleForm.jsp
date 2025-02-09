<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</head>
<body>
	
	
	<!-- 정보 -->
	<div class="container">
		
		<div class="row" style="height">
			<div class="col-7">1
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
							<tbody>
								
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="col-5">
				<div class="row">2</div>
				<div class="row">3</div>	
			</div>
			
		</div>
	
	</div>
	
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
	<script>
		
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
					const td_store = $("<td>")
					const td_date = $("<td>")
					const td_sale = $("<td>")
					
				}
			});
		});
		
		
	
	</script>
</body>
</html>