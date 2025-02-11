<%@ page import="java.util.*" %>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	    // AJAX로 전달된 근무시간과 시급 받기
	    String hoursParam = request.getParameter("hours");
	    String[] hours = hoursParam.split(",");
	    double hourlyRate = Double.parseDouble(request.getParameter("hourlyRate"));

	    double totalPay = 0;
		double totalOvertimePay = 0;
		double totalSal = 0;
		
		double actualSal = 0;
	    StringBuilder tableRow = new StringBuilder();
	    String[] weekNames = {"1주차", "2주차", "3주차", "4주차", "5주차"};

	    for (int i = 0; i < hours.length; i++) {
	        int workedHours = Integer.parseInt(hours[i]);

	        // 주휴수당 계산: 주 15시간 이상 근무 시 1일 급여 추가 (시급 * 8시간)
			double weeklyPay = workedHours * hourlyRate;
	        double overtimePay = 0;
	        if (workedHours >= 15) {
	            overtimePay = hourlyRate * 8; // 주휴수당
	        }

	        // 테이블 행 추가
	        tableRow.append("<tr>");
	        tableRow.append("<td>").append(weekNames[i]).append("</td>");
	        tableRow.append("<td>").append(workedHours).append("</td>");
	        tableRow.append("<td>").append(String.format("%.0f", overtimePay)).append("</td>");
	        tableRow.append("</tr>");

	        // 총 급여 및 주휴수당 합산
	        totalPay += weeklyPay;
			totalOvertimePay += overtimePay;
	    }
		totalSal = totalPay + totalOvertimePay;
		actualSal = totalSal * 0.917;
	    // JSON 응답 생성
		String jsonResponse = String.format("{\"tableRow\":\"%s\", \"totalPay\":\"%.0f\", \"totalOvertimePay\":\"%.0f\", \"totalSal\":\"%.0f\", \"actualSal\":\"%.0f\"}",
		                                    tableRow.toString(), totalPay, totalOvertimePay, totalSal, actualSal);
		response.getWriter().print(jsonResponse);
%>