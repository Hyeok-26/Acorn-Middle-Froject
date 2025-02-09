<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.List"%>
<%@page import="test.dao.Com1QuitDao"%>
<%@page import="test.dto.Com1QuitDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	// 현재 페이지 위치를 세션 영역에 저장 (관리자 전용 네비바에 활성 상태 표시 위함)
	session.setAttribute("current_page", "quitForm");

	//로그인 상태 표시 : 세션 영역에서 접속 계정 정보 가져오기
	String comname = (String)session.getAttribute("comname");
	String ename = (String)session.getAttribute("ename");

	// 페이지 로딩 uri
	String findQuery="";
	// 로딩 데이터
	Com1QuitDto dto = new Com1QuitDto();
	
		
	
	// 검색 조건이 있는지 request 영역 확인
	String condition = request.getParameter("condition");
	String keyword = (String)request.getParameter("keyword");
	// 만약 직책명으로 키워드 검색 시 소문자가 섞여 있다면 대문자로 바꿔주기
	if(condition != null && keyword != null){
		Pattern pattern = Pattern.compile("[a-z]");
		Matcher matcher = pattern.matcher(keyword);
		boolean result_reg = matcher.find();
		if(condition.equals("role") && result_reg){
			keyword = keyword.toUpperCase();
		}
	}
	// 검색 조건이 있는 경우 dto 에 값 담기
	if(condition != null && keyword != null){
		dto.setCondition(condition);
		dto.setKeyword(keyword);
		findQuery = "&condition="+condition+"&keyword="+keyword;
	}
	
	
	// 정렬 조건이 있는지 확인
	String lineup = request.getParameter("lineup");
	// 정렬 조건이 있는 경우 dto 에 값 담기
	if(lineup != null && lineup != ""){
		dto.setLineup(lineup);
	}

	
	
	// 페이징 처리
	final int PAGE_ROW_COUNT = 6;		//한 페이지에 표시할 개수
	final int PAGE_DISPLAY_COUNT = 3;	// 하단 페이지에 표시할 개수
	int pageNum = 1;	// 페이징 초기값 
	
	// 기존 페이지 번호가 있는지 request 영역 확인
	String strPageNum = request.getParameter("pageNum"); // 원래 위치하던 페이지 번호
	
	// 페이지 번호가 있는 경우
	if(strPageNum != null){
		pageNum = Integer.parseInt(strPageNum);
	}
	
	// row 기본값
	int startRowNum = (pageNum-1)*PAGE_ROW_COUNT + 1;	// 시작 row 번호 
	int endRowNum = PAGE_ROW_COUNT*pageNum;				// 마지막 row 번호
	
	// 하단 페이지 기본값
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
<title>퇴사자 관리 페이지</title>
<style>
	/* div{ border:1px solid red; } */

</style>
<!-- 페이지 로딩에 필요한 자원 -->
<jsp:include page="/include/resource.jsp"></jsp:include>
</head>
<body>
	
	<!-- 관리자 페이지 전용 네비바 -->
	<jsp:include page="/include/ceoNav.jsp"></jsp:include>
 
	<!-- 현재 접속 상태 표시 -->
	<div>
	<p><%=comname %>의  <%=ename %>님 접속 중</p>
	</div>
	
	
	<!-- 본문 -->
	<div class="container contents text-center mt-3 mx-auto" style="width:900px;">
		<h4>퇴사자 명단</h4>
		
		<!--상단 컨트롤 바-->
		<div class="controlbar d-flex mt-2">
			
			<!-- 조회 버튼-->
			<div class="p-2">
				<div class="input-group">
					<select v-model="condition"  name="condition" class="btn btn-outline-dark dropdown-toggle">
							<option value="ename">이름</option>
							<option value="storenum">지점</option>
							<option value="role">직책</option>
							<option value="empno">사원번호</option>
					</select>
					<input v-model="keyword" type="text" name="keyword" placeholder=" 입력하세요.." />
					<button @click="onSearch" class="btn btn-outline-dark">검색</button>
				</div>
			</div>
			
			
			<!-- 정렬 버튼 -->
			<div class="p-2">
				<div class="input-group">
					<button type="button" class="btn btn-outline-dark" disabled>정렬 조건</button>
					<select v-model="lineup" name="lineup" @change="onSearch" class="btn btn-outline-dark dropdown-toggle">
							<option value="">선택</option>
							<option value="quitdate">퇴사일</option>
							<option value="hiredate">입사일</option>
							<option value="empno">사원번호</option>
							<option value="ename">이름</option>
							<option value="storenum">지점</option>
					</select>
				</div>
			</div>
			
			
			<!-- 퇴사자 추가 버튼 -->
			<div class="ms-auto p-2">
				<button class="btn btn-primary" id="add_quit" data-bs-toggle="modal" data-bs-target="#showModal">퇴사자 추가</button>
			</div>
			
			<!-- 퇴사자 추가 버튼을 누르면 나오는 모달 창 -->
			<div class="modal fade" id="showModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="showModalLabel" aria-hidden="true">
				<div class="modal-dialog">
				  <div class="modal-content">
				  
				    <div class="modal-header">
				      <h1 class="modal-title fs-5" id="showModalLabel">퇴사자 추가</h1>
				      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				    </div>
				    
				    <div class="modal-body ">
				    	
				    	<!-- 데이터 조회 -->
					    <div class="mb-3 row" >
					    	<div class="col-3"><label for="search_empno" class="form-label">사원번호*</label></div>
					    	<div class="col-6"><input v-model="search_empno" type="text" class="form-control" id="search_empno" placeholder="사원번호를 입력하세요..."></div>
					    	<div class="col-3"><button @click="clickSearchBtn" class="btn btn-primary">조회</button></div>
						</div>
						
						
						<!-- 조회된 데이터 보여줌 -->
					    <form action="addQuit.jsp" @submit.prevent="onSubmit">
					    
					    	<div class="mb-3 row" style="display:none">
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
					      
					      	<!-- 이 데이터로 퇴사자 처리 -->
				      		<button class="btn btn-primary" id="addQuitBtn">퇴사 처리</button>
					    </form>
				    </div>
				  </div>
				</div>
			</div>
		</div>
		
		
		
		<!-- 퇴사자 리스트 -->	
		<div style="margin:10px;">
			<div class="table-responsive">
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
							<th>복귀</th>
						</tr>
					</thead>
					<tbody>
						<!-- 데이터가 없는 경우 -->
						<c:choose>
							<c:when test="${totalRow eq 0}">
								</tbody>
								</table>
								<div class=" justify-content-center align-items-center vh-100">
								  <div class="p-3 bg-light">퇴사자 정보가 없습니다!</div>
								</div>
								
							</c:when>
							<c:otherwise>
								<c:forEach var="qmember" items="${list}">
									<tr>
										<td>${qmember.empNo }</td>
										<td>${qmember.eName }</td>
										<td>${qmember.storeNum }</td>
										<td>${qmember.role }</td>
										<td>${qmember.hiredate }</td>
										<td>${qmember.quitdate }</td>
										<td>${qmember.eCall }</td>
										<th><a href="cancleQuit.jsp" class="btn btn-secondary btn-sm" @click.prevent="onCancle">복귀</a></th>
									</tr>
								</c:forEach>
									</tbody>
									</table>
							</c:otherwise>
						</c:choose>
			</div>
		</div>
		
		
		
		
		
		
		<!-- 하단 페이징 버튼 -->
		<div class="mt-3 d-flex justify-content-center">
			<nav>
				<ul class="pagination mx-auto">
					<!-- Prev 버튼 -->
					<c:if test="${startPageNum ne 1}">
						<li class="page-item">
							<a class="page-link" href="quitForm.jsp?pageNum=${startPageNum - 1}${findQuery}">Prev</a>
						</li>
					</c:if>
					<!-- 페이지 번호 -->
					<c:forEach begin="${startPageNum}" end="${endPageNum}" var="i">
						<li class="page-item ${i == pageNum ? 'active' : ''}">
							<a class="page-link" href="quitForm.jsp?pageNum=${i}${findQuery}">${i}</a>
						</li>
					</c:forEach>
					<!-- Next 버튼 -->
					<c:if test="${endPageNum < totalPageCount}">
						<li class="page-item">
							<a class="page-link" href="quitForm.jsp?pageNum=${endPageNum + 1}${findQuery}">Next</a>
						</li>
					</c:if>
				</ul>		
			</nav>
		</div>
		
		
		
		
		<!-- 추가 가능 -->
		<div class="mt-3 d-flex justify-content-end">
			<button class="btn btn-primary btn-sm">경력증명서 출력</button>
		</div>
	
	</div>
	
	
	
	<!-- 푸터 -->
	<div class="position-fixed bottom-0 w-100">
  	<jsp:include page="/include/footer.jsp" />
  	</div>
  	
  	
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script>
		new Vue({
			el:".container",
			data:{
				search_empno:"",
				dto:"",
				lineup:"${dto.lineup}",
				condition:"${empty dto.condition ? 'ename' : dto.condition}",
				keyword:"${empty dto.keyword ? '' : dto.keyword}"
			},
			methods:{
				onSearch(){
					if(this.keyword == ""){
						location.href="quitForm.jsp?lineup="+this.lineup;
					}else{
						location.href="quitForm.jsp?condition="+this.condition+"&keyword="+this.keyword+"&lineup="+this.lineup;
					}
					
				},
				// 모달창에서 사원 조회
				clickSearchBtn(){
					fetch("searchInfo.jsp?empno="+this.search_empno)
					.then(res => res.json())
					.then(data=>{
						// 만약 없는 사원번호를 입력했을 경우
						if(!data.isExist){
							alert("없는 사원번호 입니다.");
						} else {
							this.dto = data.dto;
						}
					})
					.catch((err)=>{
						console.log(err);
					});
					
					
				},
				// 퇴사자 복귀
				onCancle(e){
					// 복귀 처리 할 사람의 정보 추출
					const empno = e.target.parentElement.parentElement.childNodes[0].innerText;
					const ename = e.target.parentElement.parentElement.childNodes[2].innerText;
					
					// 복귀 처리 한 번 더 물어보기
					const answer = confirm(ename+"("+empno+")" +" 을(를) 복귀 처리 하시겠습니까?");
					
					// 대답이 긍정이라면 복귀 처리 하기
					if(answer){
						fetch("cancleQuit.jsp",{
							method:"POST",
							headers:{"Content-Type":"application/x-www-form-urlencoded; charset=utf-8"},
							body: "empno="+empno
						})
						.then(res => res.json())
						.then(data=>{
							console.log(data);
							if(data.isAddSuccess && data.isDeleteSuccess){
								alert(ename+"("+empno+") 을(를) 복귀 처리 하였습니다.");
							} else if(data.isAddSuccess){
								alert("QUIT 테이블에서 삭제 실패. 개발자 확인 요망!");
							} else {
								alert("EMP 테이블에 추가 실패. 개발자 확인 요망!");
							}
							location.href = "quitForm.jsp";
						})
						.catch((err)=>{
							console.log(err);
						});
					}
				},
				// 퇴사자 추가 
				onSubmit(e){
					// 폼 입력이 제대로 이루어 졌는지 확인
					const data = new FormData(e.target);
					const empno = e.target.empno.value;
					const ename = e.target.ename.value
					const quitdate = e.target.quitdate.value;
					
					// 만약 사원 번호(사원 정보)가 없는 경우
					if(empno == ""){
						alert("사원 번호를 입력하세요");
					// 정보가 조회되지 않은 경우
					} else if(ename == "") {
						alert("조회 버튼을 눌러주세요")
					} else if(ename == 'null'){
						alert("정보가 없습니다");	
					// 만약 퇴사일을 선택하지 않은 경우
					} else if(quitdate == "") {
						alert("퇴사일을 입력하세요");
					// 위 경우가 모두 아니라면 퇴사 처리 진행
					} else {
						const queryString = new URLSearchParams(data).toString();
						const url = e.target.action;
						
						fetch(url,{
							method:"POST",
							headers:{"Content-Type":"application/x-www-form-urlencoded; charset=utf-8"},
							body: queryString
						})
						.then(res => res.json())
						.then(data=>{
							console.log(data);
							if(data.isAddSuccess && data.isDeleteSuccess){
								alert(ename+"("+empno+") 을(를) "+quitdate+" 일자로 퇴사 처리 하였습니다.");
							} else if(data.isAddSuccess){
								alert("EMP 테이블에서 삭제 실패. 개발자 확인 요망!");
							} else {
								alert("QUIT 테이블에 추가 실패. 개발자 확인 요망!");
							}
							location.href = "quitForm.jsp";
						})
						.catch((err)=>{
							console.log(err);
						});
					}
				}
			}//methods
			
		});
	</script>
</body>
</html>