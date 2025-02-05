<%@page import="test.dto.Com1SchDto"%>
<%@page import="java.util.List"%>
<%@page import="test.dao.Com1SchDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("storenum"));
	//dao이용해서 회원목록 얻어오기
	Com1SchDao dao=Com1SchDao.getInstance();
	List<Com1SchDto> list=dao.getListSchStore(num);
	
    String schdate = "";
    if (!list.isEmpty()) {
        schdate = list.get(0).getSchdate();  // 첫 번째 row의 schdate 값 가져오기
    }

    String srcurl = "";
    if (!list.isEmpty()) {
    	srcurl = list.get(0).getSrcurl();  // 첫 번째 row의 schdate 값 가져오기
    }
    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원스케줄조회</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	
	<%--main컨텐츠감싸기 --%>
	<div class="main flex-grow-1">  
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg">
                    <div class="card shadow-sm p-4">
						<h1><%=num %>호점 <%=schdate %>월 근무표조회</h1>
						
						<%--업로드 버튼--%>
						<div class="d-flex justify-content-between mb-3">
			     	    <a href="uploadform.jsp?storenum=<%=num %>" class="btn btn-primary mt-3" role="button" >근무표업로드</a>
			     	    <%--삭제 버튼--%>
			     	    <a href="delete.jsp?storenum=<%=num %>&date=<%=schdate %>" class="btn btn-danger mt-3" role="button" >근무표삭제</a>
			    	    </div>
                    	<img src="<%=srcurl %>" alt="직원근무표" id="" />
                  </div>
              </div>                          
          </div>			
			
			
			
			
			
		</div>    	
    </div> <%--main --%>
	<%--푸터 --%>
    <jsp:include page="/include/footer.jsp" />
</body>
</html>