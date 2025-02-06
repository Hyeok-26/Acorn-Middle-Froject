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
</style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<%--main컨텐츠감싸기 --%>
	<div class="main flex-grow-1">  
		<div class="container">
		
			<h1>근무시간변경</h1>
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
					<input class="form-control" type="text" name="sal" id="sal" value="<%=dto.getSal()%>" required oninput="salInput()" />
				</div>
				<div class="mb-3">
					<label class="form-label">시급</label> 
					<input class="form-control" type="text" name="hsal" id="hsal" value="<%=dto.getHsal()%>" required oninput="hsalInput()"/>
				</div>
				<div class="mb-3">
					<label class="form-label">근무시간</label> 
					<input class="form-control" type="test" name="worktime" id="worktime" value="<%=dto.getWorktime()%>" required oninput="hsalInput()"/>
				</div>
				<button class="btn btn-success" type="submit" >수정하기</button>
				<button class="btn btn-danger" type="reset">리셋</button>


			</form>
	
		</div>
	</div> <%--메인 --%>
	<%--푸터 --%>
	<jsp:include page="/include/footer.jsp" />
	<script>
    function salInput() {
        let sal = document.getElementById("sal");
        let hsal = document.getElementById("hsal");
        let worktime = document.getElementById("worktime");

        if (sal.value.trim() !== "") {
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

        if (hsal.value.trim() !== "" || worktime.value.trim() !== "") {
        	sal.setAttribute("readonly","");
            
            sal.value = "0";
        }
        else {
        	sal.removeAttribute("readonly");
        }
    }
</script>

</body>
</html>
