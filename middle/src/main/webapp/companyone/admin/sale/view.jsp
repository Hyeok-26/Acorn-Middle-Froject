<%@page import="java.util.List"%>
<%@page import="test.dao.Com1SaleDao"%>
<%@page import="test.dto.Com1SaleDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%
	///매출 폼에서 입력한 값 받아옴
	String salemonth=request.getParameter("salemonth");
	int monthlysal=Integer.parseInt(request.getParameter("monthlysal"));
	
	//dto에 입력값 담고
	Com1SaleDto dto=new Com1SaleDto();
	dto.setSalemonth(salemonth);
	dto.setMonthlysal(monthlysal);
	
	//dao를 통해서 올리기
	boolean isSuccess=Com1SaleDao.getInstance().insert(dto);
	
	//getlist list가 null 아닐 때 
	List<Com1SaleDto> list=Com1SaleDao.getInstance().getList();

	
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출조회 페이지</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.css">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
  <!-- 네비게이션 바 -->
  <jsp:include page="/include/navbar.jsp">
    <jsp:param value="index" name="current" />
  </jsp:include>

  <!-- 메인 컨텐츠 -->
  <div class="container flex-grow-1 my-4">
    <!-- 버튼 -->
    <div class="d-flex justify-content-between mb-3">
      <a href="${pageContext.request.contextPath}/companyone/admin/sale/updateform.jsp" class="btn btn-success mt-3" role="button" >매출추가</a>
    </div>
 
    <!-- 테이블 -->
		<table class="table table-bordered table-hover text-center">
			<thead class="table-success">
				<tr>
					<th>월</th>
					<th>매출</th>
					<th>매출현황</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>

  <!-- 푸터 -->
  <jsp:include page="/include/footer.jsp" />
</body>
</html>