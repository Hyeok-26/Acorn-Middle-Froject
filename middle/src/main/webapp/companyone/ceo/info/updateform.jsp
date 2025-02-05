<%@page import="test.dao.Com1CeoDao"%>
<%@page import="test.dto.Com1CeoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

	int empno = (int) session.getAttribute("empno");
	Com1CeoDao dao = Com1CeoDao.getInstance();
	Com1CeoDto dto = dao.getData(empno);
	
	// 로그인한 사용자의 정보를 DB에서 가져오기 (예시)
	Com1CeoDto ceoInfo = Com1CeoDao.getInstance().getData(empno); // 사원번호를 이용하여 CEO 정보를 조회
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/ceo/protected/updateform_ceo</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
<style>
</style>
</head>
<body>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<div class="container" id="app">
		<h3>회원 정보 수정 양식</h3>
		<form action="update.jsp" method="get" id="callupdateForm">
			<div>
				<div class="mb-2">
					<label class="form-label" for="ename">관리자 이름</label> 
					<input class="form-control" type="text" id="ename" value="<%=dto.geteName() %>" readonly />
				</div>
				<div class="mb-2">
					<label class="form-label" for="callnum">연락처</label> 
					<input class="form-control" placeholder="<%=dto.geteCall() %>" @input="onCallInput" :class="{'is-invalid': !isCallValid && isCallDirty, 'is-valid':isCallValid}"
						type="text" name="callnum" id="callnum" />
					<div class="invalid-feedback">전화번호 형식에 맞지 않습니다.</div>
				</div>
			</div>
			<div class="mb-2">
				<label class="form-label" for="password">기존 비밀번호</label> 
				<input class="form-control" @input="onPwdInput"	:class="{'is-invalid': !isPwdValid && isPwdDirty, 'is-valid':isPwdValid}"
					type="password" name="password" id="password" />
				<div class="invalid-feedback">반드시 입력하세요</div>
			</div>
			<div class="mb-2">
				<label class="form-label" for="newPassword">새 비밀번호</label> 
				<input class="form-control" type="password" name="newPassword" id="newPassword" @input="onNewPwdInput" v-model="newPassword"
					:class="{'is-invalid': !isNewPwdValid && isNewPwdDirty, 'is-valid':isNewPwdValid}" />
				<small class="form-text">반드시 입력하고 아래의 확인란과 동일해야 합니다</small>
				<div class="invalid-feedback">새 비밀번호를 확인하세요</div>
			</div>
			<div class="mb-2">
				<label class="form-label" for="newPassword2">새 비밀번호 확인</label> 
				<input class="form-control" type="password" id="newPassword2" @input="onNewPwdInput" v-model="newPassword2" />
			</div>
			<button class="btn btn-success" type="submit" :disabled="!isPwdValid || !isNewPwdValid">수정하기</button>
			<button class="btn btn-danger" type="reset">리셋</button>
		</form>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script>
		new Vue({
			el:"#app",
			data:{
				isPwdValid:false,
				isNewPwdValid:false,
				isCallValid:false,
				callnum:"",
				newPassword:"",
				newPassword2:"",
				isCallDirty:false,
				isPwdDirty:false,  //비밀번호 입력란에 한번이라도 입력했는지 여부
				isNewPwdDirty:false //새비밀번호 입력한에 한번이라도 입력했는지 여부 
			},
			methods:{
				onCallInput(e){
					//현재까지 입력한 비밀번호
					const callnum=e.target.value;
					//공백이 아닌 한글자가 한번이상 반복 되어야 통과 되는 정규표현식
					const reg_callnum=/^01[016789]-\d{3,4}-\d{4}$/;
					if(reg_callnum.test(callnum)){
						this.isCallValid=true;
					}else{
						this.isCallValid=false;
					}
					this.isCallDirty=true;
				},
				onPwdInput(e){
					//현재까지 입력한 비밀번호
					const pwd=e.target.value;
					//공백이 아닌 한글자가 한번이상 반복 되어야 통과 되는 정규표현식
					const reg_pwd=/[\S]+/;
					if(reg_pwd.test(pwd)){
						this.isPwdValid=true;
					}else{
						this.isPwdValid=false;
					}
					this.isPwdDirty=true;
				},
				onNewPwdInput(){
					//공백이 아닌 글자를 하나이상 입력했는지 확인할 정규 표현식
					const reg_pwd=/[\S]+/;
					//만일 정규표현식도 통과하고 그리고 두개의 비밀번호가 같다면 
					if(reg_pwd.test(this.newPassword) && (this.newPassword === this.newPassword2)){
						//새 비밀번호 유효성 여부를 true 로 변경
						this.isNewPwdValid = true;
					}else{//그렇지 않다면
						//새 비밀번호 유효성 여부를 false 로 변경 
						this.isNewPwdValid = false;
					}
					this.isNewPwdDirty=true;
				}
			}
		});
	</script>
	<jsp:include page="/include/footer.jsp" />
</body>
</html>