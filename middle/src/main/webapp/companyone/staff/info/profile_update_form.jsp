<%@page import="test.dao.Com1EmpDao"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int empno = (int) session.getAttribute("empno");
	Com1EmpDto dto = Com1EmpDao.getInstance().getData(empno);
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
	<jsp:include page="/include/navbar.jsp"></jsp:include>

	<div id="app">
		<div class="container2">
			<h1>프로필 수정</h1>
			<form action="profile_update.jsp" method="post" id="myForm">
				<div class="mb-3">
					<label class="form-label">회사번호</label> <input class="form-control"
						type="text" name="comid" value="<%=dto.getComId()%>" readonly />
				</div>
				<div class="mb-3">
					<label class="form-label">사원번호</label> <input class="form-control"
						type="text" name="empno" value="<%=dto.getEmpNo()%>" readonly />
				</div>
				<div class="mb-3">
					<label class="form-label">이름</label> <input class="form-control"
						type="text" name="ename" value="<%=dto.geteName()%>" required />
				</div>
				<div class="mb-3">
					<label class="form-label">전화번호</label> <input class="form-control"
						type="text" name="ecall" value="<%=dto.geteCall()%>" required />
				</div>
				<div class="mb-3">
					<label class="form-label">이메일</label> <input class="form-control"
						type="email" name="email" value="<%=dto.getEmail()%>" required />
				</div>
				<div class="mb-3">
					<label class="form-label">기존 비밀번호</label> <input
						class="form-control" type="password" name="password"
						v-model="password" @input="validateOldPassword"
						:class="{'is-invalid': !isPwdValid && isPwdDirty, 'is-valid': isPwdValid}" />
					<div class="invalid-feedback">반드시 입력하세요</div>
				</div>
				<div class="mb-3">
					<label class="form-label">새 비밀번호 (선택사항)</label> <input
						class="form-control" type="password" name="newPassword"
						v-model="newPassword" @input="validateNewPassword"
						:class="{'is-invalid': !isNewPwdValid && isNewPwdDirty, 'is-valid': isNewPwdValid}" />
					<small class="form-text">비밀번호 변경을 원할 경우만 입력하세요.</small>
					<div class="invalid-feedback">비밀번호 조건을 확인하세요 (최소 6자 이상)</div>
				</div>
				<div class="mb-3">
					<label class="form-label">새 비밀번호 확인</label> <input
						class="form-control" type="password" v-model="newPassword2"
						@input="validateNewPassword"
						:class="{'is-invalid': newPassword !== newPassword2 && newPassword2 !== '', 'is-valid': newPassword === newPassword2 && newPassword2 !== ''}" />
				</div>
				<button class="btn btn-success" type="submit"
					:disabled="!isPwdValid || (newPassword !== '' && !isNewPwdValid)">수정하기</button>
				<button class="btn btn-danger" type="reset">리셋</button>
			</form>
		</div>
	</div>
	<jsp:include page="/include/footer.jsp" />
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script>
        new Vue({
            el: "#app",
            data: {
                comid: "<%=dto.getComId()%>",
                empno: "<%=dto.getEmpNo()%>",
                ename: "<%=dto.geteName()%>",
                ecall: "<%=dto.geteCall()%>",
                email: "<%=dto.getEmail()%>",
                password: "",
                newPassword: "",
                newPassword2: "",
                isPwdValid: false,
                isNewPwdValid: false,
                isPwdDirty: false,
                isNewPwdDirty: false
            },
            methods: {
                validateOldPassword() { 
                    this.isPwdDirty = true; 
                    this.isPwdValid = this.password.trim() !== "";
                },
                validateNewPassword() { 
                    this.isNewPwdDirty = true;
                    this.isNewPwdValid = this.newPassword.length >= 6 && this.newPassword === this.newPassword2;
                }
            }
        });
    </script>
</body>
</html>
