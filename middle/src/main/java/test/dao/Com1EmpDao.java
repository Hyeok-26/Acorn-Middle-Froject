package test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.dto.Com1EmpDto;
import test.util.DbcpBean;

public class Com1EmpDao {
	
	private static Com1EmpDao dao;
	
	static {
		dao = new Com1EmpDao();
	}
	
	private Com1EmpDao() {}
	
	public static Com1EmpDao getInstance() {
		return dao;
	}
	
	public boolean insert(Com1EmpDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					insert into test_com1_emp
					(comid, storenum, empno, ename, role, ecall, epwd, email)
					values(?, ?, ?, ?,?,?,?,?)
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값을 여기서 바인딩한다.
			pstmt.setInt(1, dto.getComId());
			pstmt.setInt(2, dto.getStoreNum());
			pstmt.setInt(3, dto.getEmpNo());
			pstmt.setString(4, dto.geteName());
			pstmt.setString(5, dto.getRole());
			pstmt.setString(6, dto.geteCall());
			pstmt.setString(7, dto.getePwd());
			pstmt.setString(8, dto.getEmail());
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

	public Com1EmpDto getData(int empno) {
		// Dto 만들기
		Com1EmpDto dto = new Com1EmpDto();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection Pool 로 부터 Connection 객체 하나 가져오기 
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = """
					select * from test_com1_emp
					where empno=?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩할게 있으면 여기서 하기
			pstmt.setInt(1, empno);
			//sql 문 실행하고 결과를 ResultSet 객체로 리턴받기
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setComId(rs.getInt("comid"));
				dto.setStoreNum(rs.getInt("storenum"));
				dto.setEmpNo(empno);
				dto.seteName(rs.getString("ename"));
				dto.setRole(rs.getString("role"));
				dto.seteCall(rs.getString("ecall"));
				dto.setePwd(rs.getString("epwd"));
				dto.setSal(rs.getInt("sal"));
				dto.setHsal(rs.getInt("hsal"));
				dto.setWorktime(rs.getInt("worktime"));
				dto.setEmail(rs.getString("email"));
				//dto.setHiredate(rs.getString("hiredate"));
				dto.setHiredate((rs.getString("hiredate")).substring(0,(rs.getString("hiredate")).indexOf(" ")));
				dto.setContract(rs.getString("contract"));
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
		return dto;
	}

	public boolean update(Com1EmpDto dto) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					update test_com1_emp
					set ename=?, ecall=?, epwd=?, sal=?, hsal=?, worktime=?, email=?, contract=?
					where empno=?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값을 여기서 바인딩한다.
			pstmt.setString(1, dto.geteName());
			pstmt.setString(2, dto.geteCall());
			pstmt.setString(3, dto.getePwd());
			pstmt.setInt(4, dto.getSal());
			pstmt.setInt(5, dto.getHsal());
			pstmt.setInt(6, dto.getWorktime());
			pstmt.setString(7, dto.getEmail());
			pstmt.setString(8, dto.getContract());
			pstmt.setInt(9, dto.getEmpNo());
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

	public boolean delete(int empno) {
		
		Connection conn = null;
        PreparedStatement pstmt = null;
        int rowCount = 0;
        try {
            conn = new DbcpBean().getConn();
            String sql = """
                delete from test_com1_emp
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

	public List<Com1EmpDto> getList(){
		// List 만들기
		List<Com1EmpDto> list = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// Connection Pool 로 부터 Connection 객체 하나 가져오기
			conn = new DbcpBean().getConn();
			// 실행할 sql 문 작성
			String sql = """
					select * from test_com1_emp
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩할게 있으면 여기서 하기
		
			// sql 문 실행하고 결과를 ResultSet 객체로 리턴받기
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// Dto 만들고 list.add
				Com1EmpDto dto = new Com1EmpDto();
				dto.setComId(rs.getInt("comid"));
				dto.setStoreNum(rs.getInt("storenum"));
				dto.setEmpNo(rs.getInt("empno"));
				dto.seteName(rs.getString("ename"));
				dto.setRole(rs.getString("role"));
				dto.setRole(rs.getString("role"));
				dto.seteCall(rs.getString("ecall"));
				dto.setePwd(rs.getString("epwd"));
				dto.setSal(rs.getInt("sal"));
				dto.setHsal(rs.getInt("hsal"));
				dto.setWorktime(rs.getInt("worktime"));
				dto.setEmail(rs.getString("email"));
				dto.setHiredate(rs.getString("hiredate"));
				dto.setContract(rs.getString("contract"));
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

	public List<Com1EmpDto> getListAdmin(){
		// List 만들기
		List<Com1EmpDto> list = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// Connection Pool 로 부터 Connection 객체 하나 가져오기
			conn = new DbcpBean().getConn();
			// 실행할 sql 문 작성
			String sql = """
					select * from test_com1_emp
					where role = ?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩할게 있으면 여기서 하기
			pstmt.setString(1, "ADMIN");
			// sql 문 실행하고 결과를 ResultSet 객체로 리턴받기
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// Dto 만들고 list.add
				Com1EmpDto dto = new Com1EmpDto();
				dto.setComId(rs.getInt("comid"));
				dto.setStoreNum(rs.getInt("storenum"));
				dto.setEmpNo(rs.getInt("empno"));
				dto.seteName(rs.getString("ename"));
				dto.setRole(rs.getString("role"));
				dto.seteCall(rs.getString("ecall"));
				dto.setePwd(rs.getString("epwd"));
				dto.setSal(rs.getInt("sal"));
				dto.setHsal(rs.getInt("hsal"));
				dto.setWorktime(rs.getInt("worktime"));
				dto.setEmail(rs.getString("email"));
				dto.setHiredate(rs.getString("hiredate"));
				dto.setContract(rs.getString("contract"));
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
	
	public List<Com1EmpDto> getListStaff(){
		// List 만들기
		List<Com1EmpDto> list = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// Connection Pool 로 부터 Connection 객체 하나 가져오기
			conn = new DbcpBean().getConn();
			// 실행할 sql 문 작성
			String sql = """
					select * from test_com1_emp
					where role = ?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩할게 있으면 여기서 하기
			pstmt.setString(1, "STAFF");
			// sql 문 실행하고 결과를 ResultSet 객체로 리턴받기
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// Dto 만들고 list.add
				Com1EmpDto dto = new Com1EmpDto();
				dto.setComId(rs.getInt("comid"));
				dto.setStoreNum(rs.getInt("storenum"));
				dto.setEmpNo(rs.getInt("empno"));
				dto.seteName(rs.getString("ename"));
				dto.setRole(rs.getString("role"));
				dto.seteCall(rs.getString("ecall"));
				dto.setePwd(rs.getString("epwd"));
				dto.setSal(rs.getInt("sal"));
				dto.setHsal(rs.getInt("hsal"));
				dto.setWorktime(rs.getInt("worktime"));
				dto.setEmail(rs.getString("email"));
				dto.setHiredate(rs.getString("hiredate"));
				dto.setContract(rs.getString("contract"));
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

	public List<Com1EmpDto> getListByStoreNum(int storenum){
		// List 만들기
		List<Com1EmpDto> list = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// Connection Pool 로 부터 Connection 객체 하나 가져오기
			conn = new DbcpBean().getConn();
			// 실행할 sql 문 작성
			String sql = """
					select * from test_com1_emp
					where storenum = ?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩할게 있으면 여기서 하기
			pstmt.setInt(1, storenum);
			// sql 문 실행하고 결과를 ResultSet 객체로 리턴받기
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// Dto 만들고 list.add
				Com1EmpDto dto = new Com1EmpDto();
				dto.setComId(rs.getInt("comid"));
				dto.setEmpNo(rs.getInt("empno"));
				dto.seteName(rs.getString("ename"));
				dto.setRole(rs.getString("role"));
				dto.seteCall(rs.getString("ecall"));
				dto.setePwd(rs.getString("epwd"));
				dto.setSal(rs.getInt("sal"));
				dto.setHsal(rs.getInt("hsal"));
				dto.setWorktime(rs.getInt("worktime"));
				dto.setEmail(rs.getString("email"));
				dto.setHiredate(rs.getString("hiredate"));
				dto.setContract(rs.getString("contract"));
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

	public boolean isDuplicateEcall(String ecall) {
		boolean isDuplicate = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT COUNT(*) FROM test_com1_emp WHERE ecall = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ecall); // 전화번호 바인딩

			rs = pstmt.executeQuery();
			if (rs.next()) {
				int count = rs.getInt(1); // COUNT 결과 가져오기
				isDuplicate = count > 0; // 1개 이상이면 중복
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
				e.printStackTrace();
			}
		}

		return isDuplicate;
	}
	
	public boolean isDuplicateEmail(String email) {
		boolean isDuplicate = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT COUNT(*) FROM test_com1_emp WHERE email = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email); // 전화번호 바인딩

			rs = pstmt.executeQuery();
			if (rs.next()) {
				int count = rs.getInt(1); // COUNT 결과 가져오기
				isDuplicate = count > 0; // 1개 이상이면 중복
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
				e.printStackTrace();
			}
		}

		return isDuplicate;
	}
}
