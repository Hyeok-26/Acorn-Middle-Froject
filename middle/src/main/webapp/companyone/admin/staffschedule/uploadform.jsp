<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원스케줄업로드폼</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
<style>
    /* 이미지 미리보기 스타일 */
    #preview {
        max-width: 100%;
        height: auto;
        display: none;
        margin-top: 15px;
        border-radius: 10px;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    }
</style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	
	<%--main컨텐츠감싸기 --%>
	<div class="main flex-grow-1">  
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="card shadow-sm p-4">
						<h1 class="text-center mb-4">직원 스케줄 업로드</h1>
						<form action="ScheduleUpload.jsp" method="post"  enctype="multipart/form-data" id="myForm">
                            <div class="mb-3">
                            	<input class="form-control" type="month" id="name" name="title" /> <br />
                                <label for="imgEmpSchedule" class="form-label">스케줄 이미지 업로드</label>
                                <input type="file" class="form-control" id="imgEmpSchedule" name="imgEmpSchedule" accept="image/*" required onchange="previewImage(event)">
                            </div>							
                            
                            <%-- 이미지 미리보기 --%>
                            <img id="preview" alt="미리보기 이미지">		
                            
                            <%-- 업로드버튼_자식요소 --%>				
							<div class="d-grid mt-3">
							<button type="submit" class="btn btn-dark mt-3">업로드</button>
							</div>	
						</form>
                  </div>
              </div>
          </div>			
			
			
			
			
			
		</div>    	
    </div> <%--main --%>
	<%--푸터 --%>
    <jsp:include page="/include/footer.jsp" />
    
    <%-- 이미지 미리보기 기능 추가 --%>
    <script>
        function previewImage(event) {
            const reader = new FileReader();
            reader.onload = function () {
                const preview = document.getElementById('preview');
                preview.src = reader.result;
                preview.style.display = 'block';
            }
            reader.readAsDataURL(event.target.files[0]);
        }

    </script>
    
</body>
</html>