<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%

int empno=(int)session.getAttribute("empno");

Com1EmpDao dao=Com1EmpDao.getInstance();
Com1EmpDto dto=dao.getData(empno);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>급여 계산</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<style>
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
<body class="d-flex flex-column min-vh-100">
<jsp:include page="/include/empNav.jsp"></jsp:include>
   <div class="container flex-fill" style="width: 600px; height:600px; margin-top: 50px;">
       <div class="d-inline-block tab-button" id="salTab" onclick="switchTab('sal')">월급</div>
       <div class="d-inline-block tab-button" id="hsalTab" onclick="switchTab('hsal')">시급</div>
   
       <div class="tab-content" id="salContent" style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: none;">
           <h1>${ename } 님 월급으로 급여 계산</h1>
           <button class="btn btn-dark" id="salBtn" style="padding: 10px;" onclick="show('sal')">급여 조회</button>
           <div class="result" id="sal">
           	   <label for="baseSal" style="padding: 10px; width: 100%;">기본급: ${sal }</label>
         	   <label for="pension" style="padding: 10px; width: 100%;">국민연금: </label>
               <label for="healthIns" style="padding: 10px; width: 100%;">건강보험료: </label>
               <label for="longIns" style="padding: 10px; width: 100%;">장기요양보험료: </label>
               <label for="empIns" style="padding: 10px; width: 100%;">고용보험료: </label>
               <label for="totalSal" style="padding: 10px; width: 100%;">지급액 계: </label>
               <p>--------------------------------------<p>
               <label for="deduction" style="padding: 10px; width: 100%;">공제액 계: </label>
               <label for="actualSal" style="padding: 10px; width: 100%;">실수령 액: </label>
               <label for="payDate" style="padding: 10px; width: 100%;">지급일: </label>
           
           
           
           </div>
               
       </div>
   
       <div class="tab-content" id="hsalContent" style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: none;">
           <h1>${ename } 님 시급으로 급여 계산</h1>
           <input type="number" id=inputMsg1 min="0" step="0.01" placeholder="1주차 근무시간 입력"/><br>
	       <input type="number" id=inputMsg2 min="0" step="0.01" placeholder="2주차 근무시간 입력"/><br>
	       <input type="number" id=inputMsg3 min="0" step="0.01" placeholder="3주차 근무시간 입력"/><br>
	       <input type="number" id=inputMsg4 min="0" step="0.01" placeholder="4주차 근무시간 입력"/><br>
	       <input type="number" id=inputMsg5 min="0" step="0.01" placeholder="5주차 근무시간 입력"/><br>
           <button class="btn btn-dark" id="hsalBtn" style="padding: 10px;" onclick="show('hsal')">급여 조회</button>
           <div class="result" id="hsal">
           		<p>기본 시급: ${hsal } 원<p>
           		<table id="hsalTable">
					<thead>
						<tr>
							<th>주차</th>
							<th>근무 시간</th>
							<th>주휴 수당</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
           
           
           	   <label for="baseSal" style="padding: 10px; width: 100%;">총 기본급: </label>
         	   <label for="allowance" style="padding: 10px; width: 100%;">총 주휴수당: </label>
               <label for="totalSal" style="padding: 10px; width: 100%;">총 급여: </label>
               <p>--------------------------------------<p>
               <label for="tax" style="padding: 10px; width: 100%;">세율: </label>
               <label for="actualSal" style="padding: 10px; width: 100%;">세율적용 급여: </label>
           
           </div>
               
       </div>
   
       
   </div>
   
   
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
       }
       
       
   </script>
   
   <jsp:include page="/include/footer.jsp" />
</body>

</html>