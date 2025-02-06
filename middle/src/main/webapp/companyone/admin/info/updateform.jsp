<%@page import="test.dto.Com1EmpDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	Com1EmpDto dto = (Com1EmpDto)session.getAttribute("dto");
	String comname = (String) session.getAttribute("comname");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점장정보조회</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.css">
<style>
	.tbl_row_wrap {
        border: 1px solid #dee2e6; /* 전체 테이블 테두리 */
        border-radius: 10px; /* 둥근 테두리 */
        padding: 20px;
        background-color: #fff; /* 테이블 배경 */
    }

    .tbl_row {
        width: 100%;
        border-collapse: separate;
    }

    .tbl_row th, .tbl_row td {
        padding: 12px;
        border-bottom: 1px solid #dee2e6; /* 행 구분선 */
    }

    .tbl_row th {
        background-color: #f8f9fa; /* 제목 부분 배경색 */
        text-align: left;
        font-weight: bold;
        width: 250px;
    }

    .tbl_row:last-child tr:last-child th, .tbl_row:last-child tr:last-child td  {
        border-bottom: none; /* 마지막 줄 구분선 제거 */
    }
    
    #modify{
    	background-color: #28A745;
    	border-color: #28A745;
    }
   
   
</style>
</head>
<body class="d-flex flex-column min-vh-100">
	<div class="main flex-grow-1">
		<jsp:include page="/include/navbar.jsp">
			<jsp:param value="index" name="current" />
		</jsp:include>
		<div class="container">
			<h1 class="mb-4">회원정보수정 페이지</h1>
			<form action="${pageContext.request.contextPath}/companyone/admin/info/update.jsp" method="post" id="updateform">
				<div class="tbl_row_wrap">
				<table class="tbl_row">
					<colgroup>
						<col style="width:264px;">
						<col style="width:auto;">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">회사이름</th>
							<td><input type="text" id="comname" name="comname" value="<%=comname %>" readonly /></td>
						</tr>
						<tr>
							<th scope="row">소속지점(storenum)</th>
							<td><input type="text" id="storenum" name="storenum" value="<%=dto.getStoreNum() %>" readonly /></td>
						</tr>
						<tr>
							<th scope="row">아이디</th>
							<td><input type="text" id="empno" name="empno" value="<%=dto.getEmpNo() %>" readonly /></td>
						</tr>
						<tr>
							<th scope="row">이름</th>
							<td><input type="text" id="ename" name="ename" value="<%=dto.geteName() %>" required/></td>
						</tr>
						<tr>
							<th scope="row">전화번호</th>
							<td><input type="text" id="phonenum" name="phonenum" value="<%=dto.geteCall() %>" required/></td>
						</tr>
						<tr>
							<th scope="row">비밀번호</th>
							<td><input type="text" id="epwd" name="epwd" value="<%=dto.getePwd() %>" required/></td>
						</tr>
						<tr>
							<th scope="row">비밀번호확인</th>
							<td><input type="text" /></td>
						</tr>
						<tr>
							<th scope="row">월급</th>
							<td><input type="text" id="sal" name="sal" value="<%=dto.getSal() %>"/></td>
						</tr>
						<tr>
							<th scope="row">시급</th>
							<td><input type="text" id="hsal" name="hsal" value="<%=dto.getHsal() %>"/></td>
						</tr>
						<tr>
							<th scope="row">근무시간</th>
							<td><input type="text" id="worktime" name="worktime" value="<%=dto.getWorktime() %>"/></td>
						</tr>
						<tr>
							<th scope="row">이메일</th>
							<td><input type="text" id="email" name="email" value="<%=dto.getEmail() %>" required/></td>
						</tr>
					</tbody>
				</table>
			</div>
				<input id="modify" class="btn btn-primary mt-3" type="submit" value="수정하기">
				<input class="btn btn-danger mt-3" type="reset" value="리셋" >
			</form>
		</div>
	</div>
	<jsp:include page="/include/footer.jsp" />

</body>
</html>