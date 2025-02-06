package test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

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
						update test_com1_emp_log
                        set check_out = SYSDATE, working_hours = (SYSDATE - check_in) * 24
                        where empno = ? and check_out is null and working_date = TRUNC(SYSDATE)
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

}