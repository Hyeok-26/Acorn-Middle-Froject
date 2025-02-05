<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    int empno = (int) session.getAttribute("empno");

    String ename = request.getParameter("ename");
    String ecall = request.getParameter("ecall");
    String email = request.getParameter("email");
    String password = request.getParameter("password"); 
    String newPassword = request.getParameter("newPassword");

    Com1EmpDao dao = Com1EmpDao.getInstance();
    Com1EmpDto dto = dao.getData(empno);

    boolean isSuccess = false;

    if (dto.getePwd().equals(password)) {
        dto.seteName(ename);
        dto.seteCall(ecall);
        dto.setEmail(email);

        if (newPassword == null || newPassword.trim().isEmpty()) {
            newPassword = dto.getePwd();
        }

        dto.setePwd(newPassword); 

        isSuccess = dao.update(dto);
    }

    if (isSuccess) {
        // 프로필 정보 갱신
        session.setAttribute("ename", dto.geteName());
        session.setAttribute("email", dto.getEmail());
    }
%>
<script>
    <% if (isSuccess) { %>
        alert("프로필이 성공적으로 수정되었습니다.");
        location.href = "<%= request.getContextPath() %>/staff/info/profile.jsp";
    <% } else { %>
        alert("기존 비밀번호가 일치하지 않습니다.");
        location.href = "<%= request.getContextPath() %>/staff/info/profile_update_form.jsp";
    <% } %>
</script>