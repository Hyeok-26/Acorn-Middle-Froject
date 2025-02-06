<%@page import="test.dao.Com1SaleDao"%>
<%@page import="java.util.List"%>
<%@page import="test.dto.Com1SaleDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<% 
    // 선택된 값 가져오기
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int storenum =Integer.parseInt(request.getParameter("storenum"));
    
	Com1SaleDao saledao = Com1SaleDao.getInstance();

	List<Com1SaleDto> listyear= saledao.getListYear(year);
	List<Com1SaleDto> liststoremonth= saledao.getStoreMonthlySales(year, month);
	Com1SaleDto storeyear= saledao.getStoreYear(storenum, year);
	Com1SaleDto storemonth= saledao.getStoreMonth(storenum, year, month);
	
	
	
    String storeOption = request.getParameter("sale");

    // 선택된 값에 따라 처리
    if (storeOption != null) {
        switch (storeOption) {
            case "all":
                // 전체매출 조회 로직
                
                out.println("전체매출을 조회합니다.");
                break;
            case "yearall":
                // 매장 전체 연매출 조회 로직
                out.println("매장 전체 연매출을 조회합니다.");
                break;
            case "monthall":
                // 매장 전체 월매출 조회 로직
                out.println("매장 전체 월매출을 조회합니다.");
                break;
            case "storeyear":
                // 매장별 연매출 조회 로직
                out.println("매장별 연매출을 조회합니다.");
                break;
            case "storemonth":
                // 매장별 월매출 조회 로직
                out.println("매장별 월매출을 조회합니다.");
                break;
            default:
                out.println("올바르지 않은 선택입니다.");
        }
    } else {
        out.println("선택된 항목이 없습니다.");
    }
%>

