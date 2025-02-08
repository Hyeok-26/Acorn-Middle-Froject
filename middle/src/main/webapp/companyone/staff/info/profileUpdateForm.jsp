<%@page import="test.dao.UsingDao"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int empno = (int) session.getAttribute("empno");
	Com1EmpDto dto = Com1EmpDao.getInstance().getData(empno);
	
	int comid = dto.getComId();
	String comname = UsingDao.getInstance().getComName(comid);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 수정</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
<style>
	.container2 {
        max-width: 600px;
        margin: 40px auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        border: 1px solid black;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    h1 {
        margin-bottom: 20px;
        color: #333;
    }
</style>
</head>
<body>
	<jsp:include page="/include/empNav.jsp"></jsp:include>
	<div id="app">
		<div class="container2">
			<h1>프로필 수정</h1>
			<form action="profileUpdate.jsp" method="post" id="myForm">
				<div class="mb-3">
					<label class="form-label">회사</label> <input class="form-control"
						type="text" name="comid" value="<%=comname%>" readonly />
				</div>
				<div class="mb-3">
					<label class="form-label">소속 지점</label> <input class="form-control"
						type="text" name="empno" value="<%=dto.getStoreNum()%>" readonly />
				</div>
				<div class="mb-3">
					<label class="form-label">이름</label> <input class="form-control"
						type="text" name="ename" value="<%=dto.geteName()%>" required />
				</div>
				<div class="mb-2">
					<label class="form-label" for="ecall">전화번호</label> <input
						v-model="ecall" @input="onEcallInput"
						:class="{'is-valid':isEcallValid,'is-invalid':!isEcallValid && isEcallDirty}"
						class="form-control" type="tel" name="ecall" id="ecall" required />
					<small class="form-text">하이픈(-)을 포함하여 기재해주세요.</small>
					<div class="invalid-feedback">전화번호를 확인하세요.</div>
				</div>
				<div class="mb-2">
					<label class="form-label" for="email">이메일</label> <input
						v-model="email" @input="onEmailInput"
						:class="{'is-valid': isEmailValid, 'is-invalid': !isEmailValid && isEmailDirty}"
						class="form-control" type="email" name="email" id="email"/>
					<div v-if="!isEmailValid && isEmailDirty" class="invalid-feedback">
						이메일 형식에 맞게 입력하세요.</div>
					<div v-if="isEmailValid && isEmailAvailable" class="valid-feedback">
						사용 가능한 이메일입니다.</div>
				</div>
				<div class="mb-2">
					<label class="form-label" for="password">기존 비밀번호</label> 
					<input class="form-control" @input="onPwdInput"	:class="{'is-invalid': !isPwdValid && isPwdDirty, 'is-valid':isPwdValid}"
						type="password" name="password" id="password" value="<%=dto.getePwd() %>" readonly/>
				</div>
				<div class="mb-2">
					<label class="form-label" for="newPassword">새 비밀번호 (선택사항)</label> 
					<input class="form-control" type="password" name="newPassword" id="newPassword" 
					    v-model="newPassword" @input="onNewPwdInput"
					    :class="{'is-invalid': !isNewPwdValid && isNewPwdDirty, 'is-valid': isNewPwdValid}" />
					<small class="form-text">영문자, 숫자, 특수문자를 포함하여 최소 8자리 이상 입력하세요.</small>
					<div v-if="!isNewPwdValid && isNewPwdDirty" class="invalid-feedback">
					    비밀번호는 영문자, 숫자, 특수문자를 포함하여 8자 이상이어야 합니다.
					</div>
					<div v-if="isNewPwdSame" class="invalid-feedback">
        				기존 비밀번호와 같습니다.
    				</div>
				</div>
				<div class="mb-2">
					<label class="form-label" for="newPassword2">새 비밀번호 확인</label> 
					<input class="form-control" type="password" name="newPassword2" id="newPassword2" 
					    @input="onNewPwdConfirmInput" v-model="newPassword2"
					    :class="{'is-invalid': !isNewPwdMatch && isNewPwdMatchDirty, 'is-valid': isNewPwdMatch && isNewPwdMatchDirty}" />
					<div class="invalid-feedback">비밀번호가 일치하지 않습니다.</div>
				</div>
				<button class="btn btn-success" type="submit">수정하기</button>
				<button class="btn btn-danger" type="reset">리셋</button>
			</form>
		</div>
	</div>
	<jsp:include page="/include/footer.jsp" />
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script>
	    new Vue({
	        el:"#app",
	        data:{
	            ename:"<%=dto.geteName()%>",
	            email:"<%=dto.getEmail()%>",
	            ecall:"<%=dto.geteCall()%>",
	            password: "<%=dto.getePwd()%>",  
	            isPwdValid:false,
	            isNewPwdValid:false,
	            isEcallValid:false,
	            isEnameValid: false,
	            isEnameDirty: false,
	            isEmailDirty: false,
	            isEmailValid: false,
	            newPassword:"",
	            newPassword2:"",
	            isNewPwdMatch: false,
	            isNewPwdMatchDirty: false,
	            isEcallDirty:false,
	            isPwdDirty:false,  // 비밀번호 입력란에 한 번이라도 입력했는지 여부
	            isNewPwdDirty:false // 새 비밀번호 입력란에 한 번이라도 입력했는지 여부
	        },
	        computed: {
	            isNewPwdSame() {
	                return this.newPassword === this.password && this.newPassword !== "";
	            }
	        },
	        methods:{
	            onEnameInput(e) {
	                this.ename = e.target.value; 
	                const reg_ename = /^[가-힣]{2,5}$/; 
	                this.isEnameDirty = true;
	                this.isEnameValid = reg_ename.test(this.ename);
	            },
	            onEcallInput(){
	                const reg_ecall=/^01[016789]-\d{3,4}-\d{4}$/;
	                this.isEcallDirty = true;
	                this.isEcallValid = reg_ecall.test(this.ecall);
	                
	                if (this.isEcallValid) {
	                    fetch("../../../checkEcall", {
	                        method: 'POST',
	                        headers: {
	                            'Content-Type': 'application/x-www-form-urlencoded'
	                        },
	                        body: 'ecall=' + encodeURIComponent(this.ecall) + '&role=' + encodeURIComponent('STAFF')
	                    })
	                    .then(res => res.json())  
	                    .then(data => {
	                        if (data.isDuplicate) {
	                            alert('이미 등록된 전화번호입니다.');  
	                            this.isEcallValid = false; 
	                            this.ecall = "";
	                        } else {
	                            alert('사용 가능한 전화번호입니다.'); 
	                        }
	                    })
	                    .catch(error => {
	                        alert('에러 발생: ' + error); 
	                    });
	                }  
	            },
	            onPwdInput(e){
	                const pwd=e.target.value;
	                const reg_pwd= /^(?=.*[A-Za-z])(?=.*\d)(?=.*\W)\S{8,}$/;
	                this.isPwdValid = reg_pwd.test(pwd);
	                this.isPwdDirty = true;
	            },
	            onNewPwdInput() {
	                this.isNewPwdDirty = true;
	                const reg_pwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*\W)\S{8,}$/;
	                this.isNewPwdValid = reg_pwd.test(this.newPassword) && !this.isNewPwdSame;
	                this.isNewPwdMatch = this.newPassword === this.newPassword2;
	            },
	            onNewPwdConfirmInput() {
	                this.isNewPwdMatch = this.newPassword === this.newPassword2;
	                this.isNewPwdMatchDirty = true;
	            },
	            onEmailInput() {
	                const reg_email = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	                this.isEmailDirty = true;
	                this.isEmailValid = reg_email.test(this.email);
	                
	                if (this.isEmailValid) {
	                    fetch("../../../checkEmail", {
	                        method: 'POST',
	                        headers: {
	                            'Content-Type': 'application/x-www-form-urlencoded'
	                        },
	                        body: 'email=' + encodeURIComponent(this.email) + '&role=' + encodeURIComponent('STAFF')
	                    })
	                    .then(res => res.json())
	                    .then(data => {
	                        if (data.isDuplicate) {
	                            alert("이미 등록된 이메일입니다.");
	                            this.isEmailValid = false;
	                            this.isEmailAvailable = false; 
	                            this.email = ''; 
	                        } else {
	                            this.isEmailAvailable = true; 
	                        }
	                    });
	                } else {
	                    this.isEmailAvailable = false; 
	                }
	            }
	        }
	    });
	</script>
</body>
</html>