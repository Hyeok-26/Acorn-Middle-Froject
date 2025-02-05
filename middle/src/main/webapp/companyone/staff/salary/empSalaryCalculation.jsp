<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>급여계산기</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
<style>
	#app{
		height: auto;
		min-height: 100%;
	  	padding-bottom: 300px;
	}
	.footer{
	  height: 300px;
	  position : relative;
	  transform : translateY(-100%);
	}

</style>
</head>
<body>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<div class="container" id="app">
		<h1>급여 계산기</h1>
	    <fieldset>
	    	<legend>월급/시급 선택</legend>
	    	<label>
	    		<input type="radio" name="salary" value="월급" id="sal"> 월급
	    	</label>
	    	<label>
	    		<input type="radio" name="salary" value="시급" id="hsal"> 시급
	    	</label>
	    </fieldset>
	    <div class="cal" style="display:none">
	        	<input type="number" id=inputMsg min="0" step="0.01" placeholder="총 근무시간 입력"/>
	            <button class="btn btn-dark" id="calBtn">급여 계산하기</button>
	          
	    </div>   
		<p id="total"></p> 	
	             
	</div>
	 
	<script>
		// 숫자를 천 단위로 구분하는 함수
	    function formatNumber(number) {
	        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }
	   function calculate(e){
		             
           const checked = e.target.value;
           if(checked == "월급"){
        	   document.querySelector(".cal").style.display = "none";
        	   document.querySelector("#total").innerText="총 급여 : 3,000,000 원";
              
           }else if(checked == "시급"){
        	   
         	   document.querySelector(".cal").style.display = "flex";
         	   document.querySelector("#total").innerText="";
         	   document.querySelector("#inputMsg").value="";
         	   document.querySelector("#calBtn").addEventListener("click", function(){
        		   const msg=document.querySelector("#inputMsg").value;
        		  	var formattedNumber = formatNumber(msg*9860);
        		   const msgs="총 급여 : "+formattedNumber+" 원";
        		   document.querySelector("#total").innerText=msgs;
         		   
       		   });
        	
        	 
           }
             
       }
       document.querySelector("#sal").addEventListener("click", calculate);
       document.querySelector("#hsal").addEventListener("click", calculate);
       
	</script>

	<jsp:include page="/include/footer.jsp" />
</body>
</html>