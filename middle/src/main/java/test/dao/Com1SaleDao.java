package test.dao;

import java.beans.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import test.dto.Com1EmpDto;
import test.dto.Com1SaleDto;
import test.util.DbcpBean;

public class Com1SaleDao {

	private static Com1SaleDao dao;

	static {
		dao = new Com1SaleDao();
	}

	private Com1SaleDao() {
	}

	public static Com1SaleDao getInstance() {
		return dao;
	}

	// 추가
	public boolean insert(Com1SaleDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					insert into test_com1_sales
					(salesDate, storeNum, dailySales)
					values(?,?,?)
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값을 여기서 바인딩한다.
			pstmt.setString(1, dto.getSaleDate());
			pstmt.setInt(2, dto.getStoreNum());
			pstmt.setInt(3, dto.getDailySales());
			// sql 문을 실행하고 변화된 row 의 개수를 리턴받기
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
			}
		}
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}

	// 삭제
	// ?호점의 ?일 매출 삭제
//	public boolean delete(String saleDate, int storeNum) {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		int rowCount = 0;
//		try {
//			conn = new DbcpBean().getConn();
//			String sql = """
//					    delete from test_com1_sales
//					    WHERE storeNum=? and saleDate=?
//					""";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(2, storeNum);
//			pstmt.setString(1, saleDate);
//
//			rowCount = pstmt.executeUpdate();
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			try {
//				if (pstmt != null)
//					pstmt.close();
//				if (conn != null)
//					conn.close();
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
//		if (rowCount > 0) {
//			return true;
//		} else {
//			return false;
//		}
//	}

	// 수정
	// 매출 수정
	public boolean update(Com1SaleDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					update test_com1_sales
					set dailySales=?
					where storeNum=? and salesDate=?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값을 여기서 바인딩한다.
			pstmt.setInt(1, dto.getDailySales());
			pstmt.setInt(2, dto.getStoreNum());
			pstmt.setString(3, dto.getSaleDate());

			// sql 문을 실행하고 변화된 row 의 개수를 리턴받기
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
			}
		}
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}

	// 하나의 데이터 얻어오기
	// 특정 날짜에 해당하는 일매출 반환
	public int getStoreDate(String saleDate, int storeNum) {
		// Dto 객체 선언
		int today_sal = 0; 

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// Connection Pool에서 Connection 객체 가져오기
			conn = new DbcpBean().getConn();
			// 실행할 SQL 문 작성
			String sql = """
					    SELECT dailySales
					    FROM test_com1_sales
					    WHERE salesDate=? and storeNum=?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩
			pstmt.setString(1, saleDate);
			pstmt.setInt(2, storeNum);

			// SQL 문 실행하고 결과를 ResultSet 객체로 받기
			rs = pstmt.executeQuery();
			if (rs.next()) {
				// Dto 객체 생성 후 값 설정
				today_sal = (int)rs.getInt("dailySales");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return today_sal;
	}

	// list 가져오기
	// 특정 매장의 특정 월매출을 반환 1줄
	public Com1SaleDto getStoreMonth(int storeNum, int year, int month) {
		Com1SaleDto dto = new Com1SaleDto();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = new DbcpBean().getConn();
			String sql = """
					SELECT extract(year from salesDate) AS year, extract(month from salesDate) AS month, storeNum,
					       SUM(dailySales) AS monthlySales
					FROM test_com1_sales
					WHERE storeNum=? AND extract(year from salesDate)=? AND extract(month from salesDate)=?
					     """;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, storeNum);
			pstmt.setInt(2, year);
			pstmt.setInt(3, month);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				dto.setYear(rs.getInt("year"));
				dto.setMonth(rs.getInt("month"));
				dto.setStoreNum(rs.getInt("storenum"));
				dto.setMonthlySales(rs.getInt("monthlySales"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return dto;
	}

	// 특정 매장의 특정 연매출 반환
	public Com1SaleDto getStoreYear(int storeNum, int year) {
		Com1SaleDto dto = new Com1SaleDto();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = new DbcpBean().getConn();
			String sql = """
					SELECT extract(year from salesDate) AS year, storeNum,
					       SUM(dailySales) AS yearlySales
					FROM test_com1_sales
					WHERE storeNum=? AND extract(year from salesDate)=?
					     """;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, storeNum);
			pstmt.setInt(2, year);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				dto.setYear(rs.getInt("year"));
				dto.setStoreNum(rs.getInt("storeNum"));
				dto.setYearlySales(rs.getInt("yearlySales"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return dto;
	}

	// 특정 매장의 모든 월매출 반환
	public List<Com1SaleDto> getListStoreMonthlySales(int year, int month) {
		List<Com1SaleDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = new DbcpBean().getConn();
			String sql = """
					SELECT extract(year from salesDate) AS year, extract(month from salesDate) AS month,
					       SUM(dailySales) AS monthlySales
					FROM test_com1_sales
					WHERE extract(year from salesDate)=? AND extract(month from salesDate)=?
					order by month asc
					     """;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, year);
			pstmt.setInt(2, month);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Com1SaleDto dto = new Com1SaleDto();
				dto.setYear(rs.getInt("year"));
				dto.setMonth(rs.getInt("month"));
				dto.setMonthlySales(rs.getInt("monthlySales"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return list;
	}

	// 모든 매장의 연간매출을 반환
	public List<Com1SaleDto> getListStoreYearlySales(int year) {
		List<Com1SaleDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = new DbcpBean().getConn();
			String sql = """
					SELECT extract(year from salesDate) AS year,
					       SUM(dailySales) AS yearlySales
					FROM test_com1_sales
					WHERE extract(year from salesDate)=?
					order by year asc
					     """;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, year);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				Com1SaleDto dto = new Com1SaleDto();
				dto.setYear(rs.getInt("year"));
				dto.setYearlySales(rs.getInt("yearlySales"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return list;
	}

	// 모든 매장번호, 일매출, 해당하는 일 반환
	public List<Com1SaleDto> getListAll() {
	    List<Com1SaleDto> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	        conn = new DbcpBean().getConn();
	        String sql = """
				SELECT *from test_com1_sales
				order by storenum, salesDate asc
	        """;
	        pstmt = conn.prepareStatement(sql);
	      
	  
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            Com1SaleDto dto = new Com1SaleDto();
	            dto.setSaleDate(rs.getString("salesDate"));
	            dto.setStoreNum(rs.getInt("storeNum"));
	            dto.setDailySales(rs.getInt("dailySales"));
	            
	            list.add(dto);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e) {
	        }
	    }
	    return list;
	}
	
}
