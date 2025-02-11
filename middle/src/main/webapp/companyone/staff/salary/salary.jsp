<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/include/header.jsp"></jsp:include>
<%
	session.setAttribute("current_page", "salary");
	int empno=(int)session.getAttribute("empno");
	String ename = (String) session.getAttribute("ename");
	
	Com1EmpDao dao=Com1EmpDao.getInstance();
	Com1EmpDto dto=dao.getData(empno);
	
	int sal=dto.getSal();
	session.setAttribute("sal", sal);
	
	int hsal=dto.getHsal();
	session.setAttribute("hsal", hsal);
	
	/*
	if( sal == null || hsal == null ) {
			response.sendRedirect("${pageContext.request.contextPath }/companyone/admin/staffsalary/view.jsp");
	}
	*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>급여 계산</title>
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
    .tab-button {
        padding: 10px 20px;
        cursor: pointer;
        font-weight: bold;
        background-color: #f1f1f1;
        border: 1px solid #ddd;
        transition: background-color 0.3s ease;
    }

    .active-tab {
        background-color: #dcdcdc; 
        border-bottom: 2px solid #999; 
    }

    .tab-content {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }
    .result {
    	display: none;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }
    th, td {
        padding: 6px 9px;
        border: 1px solid #ddd;
        text-align: center;
    }
    th {
        background-color: #c8c8c8;
    }    
    button:hover {
        background-color: grey;
    }
</style>
</head>
<body class="d-flex flex-column min-vh-100">
<jsp:include page="/include/empNav.jsp"></jsp:include>
<div class="container2">
   <div class="container flex-fill" style="width: 600px; height:650px; margin-top: 10px;">
       <div class="d-inline-block tab-button" id="salTab" onclick="switchTab('sal')">월급</div>
       <div class="d-inline-block tab-button" id="hsalTab" onclick="switchTab('hsal')">시급</div>
   
       <div class="tab-content" id="salContent" style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: none;">
           <h3>${ename } 님 월급으로 급여 계산</h3>
           <button class="btn btn-dark" id="salBtn" style="padding: 10px;" onclick="show('sal')">급여 조회</button>
           <div class="result" id="sal">
           	   <label for="baseSal" style="padding: 10px; width: 100%;">기본급: ${sal } 원</label>
         	   <label for="pension" style="padding: 10px; width: 100%;">국민연금: ${sal*0.045 } 원</label>
               <label for="healthIns" style="padding: 10px; width: 100%;">건강보험료: ${sal*0.035 } 원</label>
               <label for="longIns" style="padding: 10px; width: 100%;">장기요양보험료: ${sal*0.0045 } 원</label>
               <label for="empIns" style="padding: 10px; width: 100%;">고용보험료: ${sal*0.0009 } 원</label>
               <label for="space" style="padding: 10px; width: 100%;">--------------------------------------</label>
               <label for="totalSal" style="padding: 10px; width: 100%;">지급액 계: ${sal } 원</label>
               <label for="deduction" style="padding: 10px; width: 100%;">공제액 계: ${sal*0.0854 } 원</label>
               <label for="actualSal" style="padding: 10px; width: 100%;"><strong>실수령 액: ${sal*0.9146 } 원</strong></label>
               <label for="payDate" style="padding: 10px; width: 100%;">지급일: 2025년 02월 15일</label>
           
           
           
           </div>
               
       </div>
   
       <div class="tab-content" id="hsalContent" style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: none;">
           <h3>${ename } 님 시급으로 급여 계산</h3>
		   <form id="inputForm">
			   <label for="week1">1주차:</label>
	           <input type="number" id="week1" name="week1" min="0" step="0.01" placeholder="1주차 근무시간 입력"/><br>
			   
			   <label for="week2">2주차:</label>
			   <input type="number" id="week2" name="week2" min="0" step="0.01" placeholder="2주차 근무시간 입력"/><br>
			   
			   <label for="week3">3주차:</label>
			   <input type="number" id="week3" name="week3" min="0" step="0.01" placeholder="3주차 근무시간 입력"/><br>
			   
			   <label for="week4">4주차:</label>
			   <input type="number" id="week4" name="week4" min="0" step="0.01" placeholder="4주차 근무시간 입력"/><br>
			   
			   <label for="week5">5주차:</label>
			   <input type="number" id="week5" name="week5" min="0" step="0.01" placeholder="5주차 근무시간 입력"/><br>
	
	           <button class="btn btn-dark" id="hsalBtn" style="padding: 10px;" onclick="show('hsal')">급여 조회</button>
           </form>
		   <div class="result" id="hsal">
			
				<h7>주차별 근무시간 및 주휴수당</h7>
           		<table id="hsalTable">
					<thead>
						<tr>
							<th>주차</th>
							<th>근무시간</th>
							<th>주휴수당</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							
						</tr>
					</tbody>
				</table>
           	   <label for="hourlyRate" style="padding: 8px; width: 100%;">기본 시급: ${hsal } 원</label>
           	   <label for="baseSal" style="padding: 8px; width: 100%;">총 기본급: <span id="totalPay">0</span> 원</label>
         	   <label for="allowance" style="padding: 8px; width: 100%;">총 주휴수당: <span id="totalOvertimePay">0</span> 원</label>
               <label for="totalSal" style="padding: 8px; width: 100%;">총 급여: <span id="totalSal">0</span> 원</label>
               <label for="space" style="padding: 8px; width: 100%;">--------------------------------------</label>
               <label for="tax" style="padding: 8px; width: 100%;">세율: 8.3 % </label>
               <label for="actualSal" style="padding: 8px; width: 100%;"><strong>세율적용 급여: <span id="actualSal">0</span> 원</strong></label>
           
           </div>      
       </div>
   </div>	
</div>

  		<jsp:include page="/include/footer.jsp" />

   <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>   
   <script>
       function switchTab(tab) {
           const tabs = ['sal', 'hsal'];
   
           tabs.forEach(tab => {
               document.getElementById(tab + 'Content').style.display = 'none';
               document.getElementById(tab + 'Tab').classList.remove('active-tab');
           });
   
           document.getElementById(tab + 'Content').style.display = 'block';
           document.getElementById(tab + 'Tab').classList.add('active-tab');
       }
   
       switchTab('sal');
       
       function show(content) {
    	  
    	   const contents = ['sal', 'hsal'];
    	   
    	   contents.forEach(content => {
               document.getElementById(content).style.display = 'none';
           });
 
    	   document.getElementById(content).style.display = 'block';
    	   
    	   if(content=='sal'){
    		   $("#inputForm").show();
    		   document.getElementById("hsalTable").getElementsByTagName("tbody")[0].innerHTML="";
    	   }
       }
       
	   // 폼 제출 버튼 클릭 시 처리
       $('#hsalBtn').click(function(event) {
           event.preventDefault();  // 폼 제출 방지

		   var hours = [];
           for (let i = 1; i <= 5; i++) {
               var time = $('#week' + i).val();
               if (time) {
                   hours.push(time);
               } else {
                   alert('모든 주차별 근무시간을 입력해주세요!');
                   $("#hsal").hide();
                   return;
               }
           }

		   var hourlyRate = ${hsal };  // 시급 값
		   
           // AJAX 요청 보내기
           $.ajax({
               type: 'POST',
               url: 'salaryCalculation.jsp',  // 근무시간과 시급을 처리할 JSP 파일
               data: { hours: hours.join(","), hourlyRate: hourlyRate },
               success: function(response) {
                   // 서버에서 받은 응답으로 테이블 업데이트
                   $('#hsalTable tbody').append(response.tableRow);
                   $('#totalPay').text(response.totalPay);
				   $('#totalOvertimePay').text(response.totalOvertimePay);
				   $('#totalSal').text(response.totalSal);
				   
				   $('#actualSal').text(response.actualSal);
                   // 입력 필드 초기화
                   $('input[type="number"]').val('');
                   // 입력 폼 숨기기
              	   $("#inputForm").hide();
               },
               error: function() {
                   alert("에러가 발생했습니다.");
               }
           });
       });
	</script>

</body>
</html>