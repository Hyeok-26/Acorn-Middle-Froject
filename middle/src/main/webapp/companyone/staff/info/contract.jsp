<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

int empno=(int)session.getAttribute("empno");

Com1EmpDao dao=Com1EmpDao.getInstance();
Com1EmpDto dto=dao.getData(empno);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근로계약서</title>
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
	#contractFile{
		display: none;
	}
</style>
</head>
<body>
<jsp:include page="/include/empNav.jsp"></jsp:include>
	<div class="container2" id="app">
		<h1>근로 계약서 보기</h1>
		<form action="contractUpdate.jsp?empno=<%=empno %>" method="post" id="contractForm">
		
		<div>
			<label><strong><%=dto.geteName() %></strong> 님의 근로계약서 입니다</label>
			<div>
				<input type="file" name="contractFile" id="contractFile" accept="image/*"/>
				<input type="hidden" name="srcurl" id="srcurl" />
				<a href="javascript:" name="contractLink" id="contractLink">
					<%if(dto.getContract()==null){ %>
						<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-file-earmark-text" viewBox="0 0 16 16">
							<path d="M5.5 7a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1zM5 9.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5"/>
							<path d="M9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.5zm0 1v2A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1z"/>
						</svg>
						<p>근로계약서를 업로드해주십시오</p>	
					<%}else{ %>
						<img id="contractImage" src="<%=dto.getContract() %>" alt="계약서 이미지" />
					<%} %>
				</a>
			</div>
			<button class="btn btn-dark" type="submit">확인</button>
		</div>
		</form>	
			
	</div>
	
	<script>
		
		document.querySelector("#contractLink").addEventListener("click", ()=>{
			// input type="file" 요소를 강제 클릭해서 파일 선택 창을 띄운다.
			document.querySelector("#contractFile").click();
		});
		//새로운 이미지가 선택되었을때
		document.querySelector("#contractFile").addEventListener("change", (e)=>{
			
			//선택된 파일 배열 객체를 얻어낸다.
			const files = e.target.files;
			//만일 파일 데이터가 존재한다면
			if(files.length > 0){
				//파일로 부터 데이터를 읽어들일 객체 생성
				const reader=new FileReader();
				//로딩이 완료(파일데이터를 모드 읽었을때) 되었을때 실행할 함수 등록
				reader.onload=(event)=>{
					//읽은 파일 데이터 얻어내기 
					const data=event.target.result;
					//이미지 src 에 설정
					document.querySelector("#srcurl").value=data;
					const img=`<img src="\${data}" id="contractImage" alt="계약서 이미지">`;
					document.querySelector("#contractLink").innerHTML=img;
				};
				//파일을 DataURL 형식의 문자열로 읽어들이기
				reader.readAsDataURL(files[0]);
			}
		});
	</script>
<jsp:include page="/include/footer.jsp" />
</body>
</html>