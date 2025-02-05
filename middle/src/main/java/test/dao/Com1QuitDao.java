package test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.dto.Com1EmpDto;
import test.dto.Com1QuitDto;
import test.util.DbcpBean;

public class Com1QuitDao {

	private static Com1QuitDao dao;
	static {
		dao = new Com1QuitDao();
	}
	private Com1QuitDao() {}
	public static Com1QuitDao getInstance() {
		return dao;
	}
	
	
	
	// 새 데이터 추가하는 메소드 
	public boolean insert(Com1EmpDto dto, String quitdate) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					INSERT INTO test_com1_quit
					(comid, storenum, empno, ename, role, ecall, email, hiredate, quitdate)
					VALUES(?, ?, ?, ?,?,?,?,TO_DATE(?,'YYYY-MM-DD HH24:MI:SS'),TO_DATE(?,'YYYY-MM-DD'))
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값을 여기서 바인딩한다.
			pstmt.setInt(1, dto.getComId());
			pstmt.setInt(2, dto.getStoreNum());
			pstmt.setInt(3, dto.getEmpNo());
			pstmt.setString(4, dto.geteName());
			pstmt.setString(5, dto.getRole());
			pstmt.setString(6, dto.geteCall());
			pstmt.setString(7, dto.getEmail());
			pstmt.setString(8, dto.getHiredate());
			pstmt.setString(9, quitdate);
			
			// sql 문을 실행하고 변화된 row 의 개수를 리턴받기
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (Exception e) {
			}
		}
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}
		
	
	
	
	
	// 리스트 개수만 가져오는 메소드
	public int getCount(Com1QuitDto dto) {
		
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = new DbcpBean().getConn();
			
			// 쿼리문 생성
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT COUNT(*) AS count FROM test_com1_quit");
			
			if(dto.getCondition() != null && dto.getKeyword() != null && !dto.getKeyword().isEmpty()) {
				sql.append(" WHERE ").append(dto.getCondition()).append(" LIKE ? ");
			}
			
			pstmt = conn.prepareStatement(sql.toString()); 
			
			
			// 검색조건이 있는 경우 LIKE ? 에 값 바인딩
			if(dto.getCondition() != null && dto.getKeyword() != null && !dto.getKeyword().isEmpty()) {
				pstmt.setString(1, "%" + dto.getKeyword() + "%");
			}
			
			
			// 쿼리 실행 및 결과 추출
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {e.printStackTrace();}
		}
		
		return count;
	}
	
	
	
	
	
	
	// 리스트 정보를 가져오는 메소드
	public List<Com1QuitDto> getList(Com1QuitDto dto) {
		List<Com1QuitDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = new DbcpBean().getConn();
			
			// SQL 문 생성
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT * FROM ");
			sql.append("(SELECT result1.*, ROWNUM AS rnum FROM ");
			sql.append("(SELECT empno, ename, storenum, role, ecall, TO_CHAR(hiredate, 'YYYY.MM.DD HH24:MI') AS hiredate, TO_CHAR(quitdate, 'YYYY.MM.DD HH24:MI') AS quitdate FROM test_com1_quit ");
			if(dto.getCondition() != null && dto.getKeyword() != null && !dto.getKeyword().isEmpty()) {
				sql.append("WHERE ").append(dto.getCondition()).append(" LIKE ? ");
			}
			sql.append("ORDER BY quitdate DESC) result1) WHERE rnum BETWEEN ? AND ?");
			
			// ? 바인딩
			pstmt = conn.prepareStatement(sql.toString());
			int paramIndex = 1;
			if(dto.getCondition() != null && dto.getKeyword() != null && !dto.getKeyword().isEmpty()) {
				pstmt.setString(paramIndex++, "%" + dto.getKeyword() + "%");
			}
			pstmt.setInt(paramIndex++, dto.getStartRowNum());
			pstmt.setInt(paramIndex, dto.getEndRowNum());
			// 쿼리 실행 및 결과 추출
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Com1QuitDto tmp = new Com1QuitDto();
				tmp.setEmpNo(rs.getInt("empno"));
				tmp.seteName(rs.getString("ename"));
				tmp.setStoreNum(rs.getInt("storenum"));
				tmp.setRole(rs.getString("role"));
				tmp.seteCall(rs.getString("ecall"));
				tmp.setHiredate(rs.getString("hiredate"));
				tmp.setQuitdate(rs.getString("quitdate"));
				list.add(tmp);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {e.printStackTrace();}
		}
		System.out.println(list);
		return list;
	}
}
