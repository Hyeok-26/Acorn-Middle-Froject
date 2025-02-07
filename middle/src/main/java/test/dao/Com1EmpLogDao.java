package test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.dto.Com1EmpLogDto;
import test.util.DbcpBean;

public class Com1EmpLogDao {
	private static Com1EmpLogDao dao;

	static {
		dao = new Com1EmpLogDao();
	}

	private Com1EmpLogDao() {
	}

	public static Com1EmpLogDao getInstance() {
		return dao;
	}

	// 출근
	public boolean insertStart(Com1EmpLogDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					        insert into test_com1_emp_log
					        (logid, empno, check_in, working_date)
					        values (test_emplog_seq.NEXTVAL, ?, SYSDATE, TRUNC(SYSDATE))
					""";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getEmpno()); // 직원 번호
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

	// 퇴근
	public boolean updateFinish(Com1EmpLogDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
						UPDATE test_com1_emp_log
						SET check_out = SYSDATE
						WHERE empno = ? 
						AND check_out IS NULL 
						AND TRUNC(working_date) = TRUNC(SYSDATE)
            """;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getEmpno());

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

	public List<Com1EmpLogDto> getList(int empno) {

		List<Com1EmpLogDto> list = new ArrayList<>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			
			conn = new DbcpBean().getConn();
			
			String sql = """
					select * from test_com1_emp_log
					where empno = ?
					""";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, empno);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Com1EmpLogDto dto = new Com1EmpLogDto();
				dto.setLogid(rs.getInt("logid"));
				dto.setEmpno(empno);
				dto.setCheckIn(rs.getTimestamp("checkIn"));
				dto.setCheckOut(rs.getTimestamp("checkOut"));
				dto.setWorkingDate(rs.getDate("workingDate"));
				dto.setWorkingHours(rs.getDouble("workingHours"));
				dto.setOvertime(rs.getDouble("overtime"));
				dto.setRemarks(rs.getString("remarks"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
			}
		}
		return list;
	}
	
	//삭제
	public boolean delete(int empno) {
		
		Connection conn = null;
        PreparedStatement pstmt = null;
        int rowCount = 0;
        try {
            conn = new DbcpBean().getConn();
            String sql = """
                delete from test_com1_emp_log
                WHERE empno=?
            """;
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, empno);
            rowCount = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) {
					pstmt.close();
				}
                if (conn != null) {
					conn.close();
				}
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
}