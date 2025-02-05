package test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.dto.Com1EmpDto;
import test.dto.Com1SaleDto;
import test.util.DbcpBean;

public class Com1SaleDao {
	
	private static Com1SaleDao dao;
	
	static {
		dao=new Com1SaleDao();
	}
	
	private Com1SaleDao() {}
	
	public static Com1SaleDao getInstance() {
		return dao;
	}
	
	//추가
	public boolean insert(Com1SaleDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					insert into test_com1_sales
					(id, storenum, salemonth, monthlysal, created_at)
					values(test_saleid_seq.nextval, ? , ? ,? ,SYSDATE)
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값을 여기서 바인딩한다.
			pstmt.setInt(1, dto.getStorenum());
			pstmt.setString(2, dto.getSalemonth());
			pstmt.setInt(3, dto.getMonthlysal());
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
	
	//삭제
	//?호점의 ?월 매출 삭제
	public boolean delete(int storenum, String salemonth ) {
		Connection conn = null;
        PreparedStatement pstmt = null;
        int rowCount = 0;
        try {
            conn = new DbcpBean().getConn();
            String sql = """
                delete from test_com1_sales
                WHERE storenum=? AND salemonth=?
            """;
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, storenum);
            pstmt.setString(2, salemonth );
            rowCount = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	//수정
	//?호점의 ?월 매출 수정
	public boolean update(Com1SaleDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					update test_com1_sales
					set monthlysal=?
					where storenum=? and  salemonth=?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값을 여기서 바인딩한다.
			pstmt.setInt(1, dto.getMonthlysal());
			pstmt.setInt(2, dto.getStorenum());
			pstmt.setString(3, dto.getSalemonth());
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
	
	//하나의 데이터 얻어오기
	//?호점 하나의 달 데이터 얻어오기
	public Com1SaleDto getData(int storenum, String salemonth) {
	    // Dto 객체 선언
	    Com1SaleDto dto = null;

	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try {
	        // Connection Pool에서 Connection 객체 가져오기
	        conn = new DbcpBean().getConn();
	        // 실행할 SQL 문 작성
	        String sql = """
	            SELECT id, storenum, salemonth, monthlysal, created_at,
	                   monthlysal - LAG(monthlysal, 1, 0) OVER (PARTITION BY storenum ORDER BY TO_NUMBER(salemonth)) AS diff
	            FROM test_com1_sales
	            WHERE storenum=? AND salemonth=?
	        """;
	        pstmt = conn.prepareStatement(sql);
	        // ? 에 값 바인딩
	        pstmt.setInt(1, storenum);
	        pstmt.setString(2, salemonth);
	        // SQL 문 실행하고 결과를 ResultSet 객체로 받기
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            // Dto 객체 생성 후 값 설정
	            dto = new Com1SaleDto();
	            dto.setId(rs.getInt("id"));
	            dto.setStorenum(rs.getInt("storenum"));
	            dto.setSalemonth(rs.getString("salemonth"));
	            dto.setMonthlysal(rs.getInt("monthlysal"));
	            dto.setCreated_at(rs.getString("created_at"));
	            dto.setDiff(rs.getInt("diff")); 
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
	    return dto; 
	}

	
	//list 가져오기
	//?호점 매출정보 가져오기
	public List<Com1SaleDto> getList(int storenum) {
	    List<Com1SaleDto> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	        conn = new DbcpBean().getConn();
	        String sql = """
	            SELECT salemonth, 
	                   monthlysal, 
	                   monthlysal - LAG(monthlysal, 1, 0) OVER (PARTITION BY storenum ORDER BY TO_NUMBER(salemonth)) AS diff
	            FROM test_com1_sales
	            WHERE storenum = ?
	            ORDER BY salemonth
	        """;
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, storenum);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            Com1SaleDto dto = new Com1SaleDto();
	            dto.setSalemonth(rs.getString("salemonth"));
	            dto.setMonthlysal(rs.getInt("monthlysal"));
	            dto.setDiff(rs.getInt("diff")); // 차이값 추가

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
