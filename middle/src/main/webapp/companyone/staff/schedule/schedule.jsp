<%@page import="test.dao.Com1EmpDao"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dto.Com1SchDto"%>
<%@page import="java.util.List"%>
<%@page import="test.dao.Com1SchDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/include/header.jsp"></jsp:include>
<%
	session.setAttribute("current_page", "schedule");
	int empno = (int)session.getAttribute("empno");
	
	Com1EmpDto dto = Com1EmpDao.getInstance().getData(empno);
	int num = dto.getStoreNum();
	
	//dao이용해서 호점별 스케줄 목록 
	List<Com1SchDto> list = Com1SchDao.getInstance().getListSchStore(num);

    String schdate = "";
    if (!list.isEmpty()) {
        schdate = list.get(0).getSchdate();  
    }

    String srcurl = "";
    if (!list.isEmpty()) {
    	srcurl = list.get(0).getSrcurl(); 
    }
    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스케줄 조회</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
<style>
    #imgsrcurl {
        max-width: 100%;
        height: 600px;
        margin: 0 auto; 
        border: 2px solid #ddd; /* 테두리 추가 */
        border-radius: 8px; /* 모서리 둥글게 */
    }
    #smalltext {
        font-size: 0.8em;
        color: #888;
        margin-bottom: 3px;
    }

</style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
	<jsp:include page="/include/empNav.jsp"></jsp:include>
	
	<%--main컨텐츠감싸기 --%>
	<div class="main flex-grow-1">  
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-sm">
                    <div class="card shadow-sm p-4">
						<h1><%=num %>호점 <%=schdate %>월 근무표조회</h1>
                    		 <img src="<%=srcurl %>" alt="직원근무표" id="imgsrcurl" />
                  </div>
              </div>                          
          </div>			
			
			
			
			
			
		</div>    	
    </div> <%--main --%>
	<%--푸터 --%>
    <jsp:include page="/include/footer.jsp" />

    
</body>
</html>