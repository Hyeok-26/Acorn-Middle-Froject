<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int empno = Integer.parseInt(request.getParameter("empno"));
	String returnurl = request.getParameter("returnurl");
	Com1EmpDao dao=Com1EmpDao.getInstance();
	Com1EmpDto dto= dao.getData(empno);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근무시간 수정폼</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
<style>
	.container {
        max-width: 600px;
        margin: 40px auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        border: 1px solid black;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .invalid-feedback{
		display:none;
		color: red; 
	}
</style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
	<jsp:include page="/include/adminNav.jsp"></jsp:include>
	<%--main컨텐츠감싸기 --%>
	<div class="main flex-grow-1">  
		<div class="container" id ="app">
		
			<h1>근무시간 급여변경</h1>
			<p>알바는 시급과 근무시간만 기입 / 직원은 월급만 기입해주세요</p>
			<form action="salupdate.jsp?returnurl=<%=returnurl%>" method="post" id="myForm">
			
				<div class="mb-3">
					<label class="form-label">회사ID</label> 
					<input class="form-control" type="text" name="comid" value="<%=dto.getComId()%>" readonly />
				</div>
				<div class="mb-3">
					<label class="form-label">소속지점</label> 
					<input class="form-control" type="text" name="storenum" value="<%=dto.getStoreNum()%>" readonly />
				</div>
				<div class="mb-3">
					<label class="form-label">사원번호</label> 
					<input class="form-control" type="text" name="empno" value="<%=dto.getEmpNo()%>" readonly />
				</div>
				<div class="mb-3">
					<label class="form-label">이름</label> 
					<input class="form-control" type="text" name="ename" value="<%=dto.geteName()%>" readonly />
				</div>
				
				<div class="mb-3">
					<label class="form-label">월급</label> 
					<input class="form-control" type="text" name="sal" id="sal" value="<%=dto.getSal()%>" required oninput="salInput()"
						v-model="sal" @input="validatesal" 
						:class="{'is-invalid': !issalValid && issalDirty, 'is-valid': issalValid}"/>
					<div class="invalid-feedback">양수를 입력하세요.</div>
				</div>
				<div class="mb-3">
					<label class="form-label">시급</label> 
					<input class="form-control" type="text" name="hsal" id="hsal" value="<%=dto.getHsal()%>" required oninput="hsalInput()"
						v-model="hsal"  @input="validatehsal"
						:class="{'is-invalid': !ishsalValid && ishsalDirty, 'is-valid': ishsalValid}"/>
						<div class="invalid-feedback">양수를 입력하세요.</div>
				</div>
				<div class="mb-3">
					<label class="form-label">근무시간</label> 
					<input class="form-control" type="text" name="worktime" id="worktime" value="<%=dto.getWorktime()%>" required oninput="hsalInput()"
						v-model="worktime" @input="validateworktime"
						:class="{'is-invalid': !isworktimeValid && isworktimeDirty, 'is-valid': isworktimeValid}"/>
						<div class="invalid-feedback">양수를 입력하세요.</div>
				</div>
				<button class="btn btn-success" type="submit" id="subBtn" 
					:disabled="!(issalValid && ishsalValid && isworktimeValid)"
				>수정하기</button>
				<button class="btn btn-danger" type="reset">기존급여보기</button>
			</form>
	
		</div>
	</div> <%--메인 --%>
	<%--푸터 --%>
	<jsp:include page="/include/footer.jsp" />
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script>
    new Vue({
        el: "#app",
        data: {
            sal: "",
            hsal: "",
            worktime: "",
			
            issalDirty: false,
            issalValid: false,
            
            ishsalValid: false,
            ishsalDirty: false,
            
            isworktimeValid: false,
            isworktimeDirty: false,
        },
        methods: {
            validatesal() {
            	this.hsal= "0";
            	this.worktime= "0";
            	this.ishsalValid = true;
            	this.isworktimeValid = true;
            	
            	this.issalDirty = true;
                const reg= /^[1-9]\d*$/;
                this.issalValid = reg.test(this.sal);
                
            },
            validatehsal() {
            	this.sal= "0";
            	this.issalValid = true;
                this.ishsalDirty = true;
                const reg= /^[1-9]\d*$/;
                this.ishsalValid = reg.test(this.hsal);            	
            },
            validateworktime() {
            	this.sal= "0";
            	this.issalValid = true;
                this.isworktimeDirty = true;
                const reg= /^[1-9]\d*$/;
                this.isworktimeValid = reg.test(this.worktime);            	
            }
        }
    }); 
	//뷰
	
	/*
    function salInput() {
        let sal = document.getElementById("sal");
        let hsal = document.getElementById("hsal");
        let worktime = document.getElementById("worktime");

        if (sal.value.trim() !== ""  ) {
            hsal.setAttribute("readonly","");
            worktime.setAttribute("readonly","");
            hsal.value = "0";
            worktime.value = "0";
        	
        } else {
            hsal.removeAttribute("readonly");
           	worktime.removeAttribute("readonly");
        }
    }

    function hsalInput() {
        let sal = document.getElementById("sal");
        let hsal = document.getElementById("hsal");
        let worktime = document.getElementById("worktime");

        if ( hsal.value.trim() !== "" || worktime.value.trim() !== "" ) {
        	sal.setAttribute("readonly","");
            
            sal.value = "0";
        }
        else {
        	sal.removeAttribute("readonly");
        }
    }
    
    */
    
    

	
    
</script>

</body>
</html>
