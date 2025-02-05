<%@page import="java.util.List"%>
<%@page import="test.dao.Com1QuitDao"%>
<%@page import="test.dto.Com1QuitDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	// 현재 페이지 위치를 세션 영역에 저장 (관리자 전용 네비바에 활성 상태 표시 위함)
	session.setAttribute("current_page", "quit-form");

	//로그인 상태 표시 : 세션 영역에서 접속 계정 정보 가져오기
	String comname = (String)session.getAttribute("comname");
	String ename = (String)session.getAttribute("ename");

	// 검색 조건이 있는지 request 영역 확인
	String condition = request.getParameter("condition");
	String keyword = request.getParameter("keyword");
	
	System.out.println("condition: " +condition);
	System.out.println("keyword: "+ keyword);
	
	String findQuery=null;
	Com1QuitDto dto = new Com1QuitDto();
	
	// 검색 조건이 있는 경우 dto 에 키워드 값 담기
	if(condition != null && keyword != null){
		dto.setCondition(condition);
		dto.setKeyword(keyword);
		findQuery = "&condition="+condition+"&keyword="+keyword;
	}
	
	final int PAGE_ROW_COUNT = 6;		//한 페이지에 표시할 개수
	final int PAGE_DISPLAY_COUNT = 3;	// 하단 페이지에 표시할 개수
	int pageNum = 1;	// 페이징 초기값 
	
	// 기존 페이지 번호가 있는지 request 영역 확인
	String strPageNum = request.getParameter("pageNum"); // 원래 위치하던 페이지 번호
	
	// 페이지 번호가 있는 경우
	if(strPageNum != null){
		pageNum = Integer.parseInt(strPageNum);
	}
	
	// row 기본값: 1 ~ 3 / 4 ~ 6
	int startRowNum = (pageNum-1)*PAGE_ROW_COUNT + 1;	// 시작 row 번호 
	int endRowNum = PAGE_ROW_COUNT*pageNum;				// 마지막 row 번호
	
	// 하단 페이지 기본값: 1 ~ 2 / 3 ~ 4
	int startPageNum = ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT + 1;
	int endPageNum = startPageNum+PAGE_DISPLAY_COUNT - 1;
	
	// 전체 목록 개수 구해서 페이지 개수 계산
	int totalRow = Com1QuitDao.getInstance().getCount(dto);
	System.out.println("totalRow: " + totalRow);
	int totalPageCount = (int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	if(endRowNum > totalPageCount) endPageNum = totalPageCount;
	
	// dto 에 보여줄 시작 row 와 마지막 row 값 담기
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	// 여기까지 dto 준비 끝 (키워드값, 페이징값)
	
	// 리스트 목록 데이터 가져오기
	List<Com1QuitDto> list =  Com1QuitDao.getInstance().getList(dto);
	
	// request 영역에 필요한 정보 저장
	request.setAttribute("list", list);
	request.setAttribute("startPageNum", startPageNum);
	request.setAttribute("endPageNum", endPageNum);
	request.setAttribute("totalPageCount", totalPageCount);
	request.setAttribute("pageNum", pageNum);
	request.setAttribute("totalRow", totalRow);
	request.setAttribute("dto", dto);
	request.setAttribute("findQuery", findQuery);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/ceo/quit-form.jsp</title>
<style>
	/* div{ border:1px solid red; } */

</style>
</head>
<body>
	<jsp:include page="/include/resource.jsp"></jsp:include>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	
	<div class="container">
		<%-- 관리자 페이지 전용 네비바--%>
		<jsp:include page="/include/ceoNav.jsp"></jsp:include>
		
		<%-- 현재 접속 상태 표시 --%>
		<div class="container">
		<p><%=comname %>의  <%=ename %>님 접속 중</p>
		</div>
		
		<div class="content mt-3 text-center">
			
			
			<%--상단 컨트롤 바--%>
			<div class="controlbar mb-3" style="display:flex">
				
				<%-- 조회 --%>
				<form class="input-group" action="quit-form.jsp">
					<select name="condition" class="btn btn-outline-dark dropdown-toggle">
							<option value="ename" ${dto.condition eq 'ename' ? 'selected' : ''}>이름</option>
							<option value="storenum" ${dto.condition eq 'storenum' ? 'selected' : ''}>지점</option>
							<option value="role" ${dto.condition eq 'role' ? 'selected' : ''}>직책</option>
							<option value="empno" ${dto.condition eq 'empno' ? 'selected' : ''}>사원번호</option>
					</select>
					<input type="text" name="keyword" value="${dto.keyword}" placeholder=" 입력하세요.." />
					
					<button type="submit" class="btn btn-dark">검색</button>
				</form>
				
				
				<%-- 추가 --%>
				<div class="d-grid gap-2 col-2 mx-auto">
					<button class="btn btn-primary" id="add_quit" data-bs-toggle="modal" data-bs-target="#exampleModal">퇴사자 추가</button>
				</div>
				
				<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">
					  <div class="modal-content">
					  
					    <div class="modal-header">
					      <h1 class="modal-title fs-5" id="exampleModalLabel">퇴사자 추가</h1>
					      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					    </div>
					    
					    <%-- 퇴사자 추가 버튼을 누르면 나오는 창 --%>
					    <div class="modal-body ">
					    	
					    	<%-- 데이터 조회 
						    <div class="mb-3 row" >
						    	<div class="col-3"><label for="search_empno" class="form-label">사원번호*</label></div>
						    	<div class="col-6"><input v-model="search_empno" type="text" class="form-control" id="search_empno" placeholder="사원번호를 입력하세요..."></div>
						    	<div class="col-3"><button @click="clickSearchBtn" class="btn btn-primary">조회</button></div>
							</div>--%>
							<div class="mb-3 d-flex align-items-center">
		                         <label for="search_empno" class="form-label me-2 w-25 text-end">사원번호</label>
		                         <div class="d-flex w-75">
		                             <input v-model="search_empno" type="text" class="form-control me-2 w-50 text-end" id="search_empno" placeholder="사원번호 입력...">
		                             <button @click="clickSearchBtn">조회</button>
		                         </div>
		                     </div>
							
							
							<%-- 조회된 데이터 보여줌 --%>
						    <form action="addQuit.jsp">
						    
						    	<div class="mb-3 row" style="display:flex">
						    		<div class="col-3"><label for="empno" class="form-label">사원번호 </label></div>
						    		<div class="col-9"><input v-model="search_empno" type="text" class="form-control" id="empno" name="empno"  readonly></div>
								</div>
								
								<div class="mb-3 row" style="display:flex">
									<div class="col-3"><label for="ename" class="form-label">이름 </label></div>
						    		<div class="col-9"><input v-model="dto.ename" type="text" class="form-control" id="ename" name="ename" readonly ></div>
								</div>
								
								<div class="mb-3 row">
									<div class="col-3"><label for="store" class="form-label">영업점 </label></div>
						    		<div class="col-9"><input v-model="dto.store" type="text" class="form-control" id="store" name="store" readonly></div>
								</div>
								
								<div class="mb-3 row">
									<div class="col-3"><label for="role" class="form-label">역할 </label></div>
						    		<div class="col-9"><input v-model="dto.role" type="text" class="form-control" id="role" name="role" readonly></div>
								</div>
								
								<div class="mb-3 row">
									<div class="col-3"><label for="email" class="form-label">이메일 </label></div>
						    		<div class="col-9"><input v-model="dto.email" type="text" class="form-control" id="email" name="email" readonly></div>
								</div>
								
								<div class="mb-3 row">
									<div class="col-3"><label for="call" class="form-label">전화번호 </label></div>
						    		<div class="col-9"><input v-model="dto.call" type="text" class="form-control" id="call" name="call" readonly></div>
								</div>
						    	
						    	<div class="mb-3 row">
						    		<div class="col-3"><label for="hiredate" class="form-label">입사일 </label></div>
						    		<div class="col-9"><input v-model="dto.hiredate" type="text" class="form-control" id="hiredate" name="hiredate" readonly></div>
					  				
					  				
								</div>
								
								<div class="mb-3 row">
									<div class="col-3"><label for="quitdate" class="form-label">퇴사일 </label></div>
						    		<div class="col-9"><input type="date" class="form-control" id="quitdate" name="quitdate"></div>
					  				
					  				
								</div>
						      
						      	<%-- 이 데이터로 퇴사자 처리 --%>
					      		<button class="btn btn-primary">퇴사 처리</button>
						    </form>
					    </div>
					  </div>
					</div>
				</div>
				
				
				
			</div>
			
			
			
			<%-- 리스트 --%>	
			<div style="height:400px;">
				<table class="table table-striped">
					<thead class="table-dark">
						<tr>
							<th>사원번호</th>
							<th>이름</th>
							<th>지점</th>
							<th>직책</th>
							<th>입사일</th>
							<th>퇴사일</th>
							<th>전화번호</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="qmember" items="${list}">
							<tr>
								<td>${qmember.empNo }</td>
								<td>${qmember.eName }</td>
								<td>${qmember.storeNum }</td>
								<td>${qmember.role }</td>
								<td>${qmember.hiredate }</td>
								<td>${qmember.quitdate }</td>
								<td>${qmember.eCall }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			
			
			
			
			
			<%-- 하단 페이징 버튼 --%>
			<nav>
				<ul class="pagination mx-auto">
					<!-- Prev 버튼 -->
					<c:if test="${startPageNum ne 1}">
						<li class="page-item">
							<a class="page-link" href="quit-form.jsp?pageNum=${startPageNum - 1}${findQuery}">Prev</a>
						</li>
					</c:if>
					<!-- 페이지 번호 -->
					<c:forEach begin="${startPageNum}" end="${endPageNum}" var="i">
						<li class="page-item ${i == pageNum ? 'active' : ''}">
							<a class="page-link" href="quit-form.jsp?pageNum=${i}${findQuery}">${i}</a>
						</li>
					</c:forEach>
					<!-- Next 버튼 -->
					<c:if test="${endPageNum < totalPageCount}">
						<li class="page-item">
							<a class="page-link" href="quit-form.jsp?pageNum=${endPageNum + 1}${findQuery}">Next</a>
						</li>
					</c:if>
				</ul>		
			</nav>
			
			
			
			
			<%-- 추가 가능 --%>
			<div class="d-flex justify-content-end">
				<button class="btn btn-primary btn-sm">경력증명서 출력</button>
			</div>
		
		</div>
	
	</div>
	
	
	<jsp:include page="/include/footer.jsp" />
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script>
		new Vue({
			el:".container",
			data:{
				search_empno:"",
				isExist:false,
				dto:""
			},
			methods:{
				clickSearchBtn(){
					fetch("${pageContext.request.contextPath }/ceo_eugene/member-info.jsp?empno="+this.search_empno)
					.then(res => res.json())
					.then(data=>{
						this.isExist = data.isExist;	// 존재여부
						this.dto = data.dto;			// 인적사항
					})
					.catch((err)=>{
						console.log(err);
					});
					
					// 만약 없는 사원번호를 입력했을 경우
					if(!this.isExist){
						
					}
				}
			}
		});
	</script>
</body>
</html>