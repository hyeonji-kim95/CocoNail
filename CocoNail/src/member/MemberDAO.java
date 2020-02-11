package member;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MemberDAO {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";	
	

		private Connection getConnection() throws Exception {

			Context init = new InitialContext();

			DataSource ds = 
					(DataSource)init.lookup("java:comp/env/jdbc/coco");

			con = ds.getConnection();
			System.out.println("D연결 성공");
			return con;
		}
		
		
		
		public void CloseDB() {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
				System.out.println("자원해제 성공!");
			} catch (SQLException e) {
				System.out.println("자원해제 실패!");
				e.printStackTrace();
			}
		} // CloseDB()
		
		// ----------------------------------------------------------------------------------------------------------
		

		public int userCheck(String member_id, String member_pw) {
			int check = -1;
			
			
			try {

			con = getConnection();
	
			sql = "select * from member where member_id=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, member_id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(member_pw.equals(rs.getString("member_pw"))){
					
					check = 1;
					
				}else{
					
					check = 0;
				}
				
			}else{
				check = -1;	
			}
			
			} catch (Exception e) {
				System.out.println("userCheck메소드 오류");
			} finally {
				CloseDB();
			}
			
			return check;

		} // userCheck()
		
		

		public void insertMember(MemberBean memberbean) {
			try {
				con = getConnection();
				
				sql = "insert into member(member_id, member_pw, member_name, member_birth, member_phone, member_post, member_address, member_address2, member_address3, member_email)"
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, memberbean.getMember_id());
				pstmt.setString(2, memberbean.getMember_pw());
				pstmt.setString(3, memberbean.getMember_name());
				pstmt.setString(4, memberbean.getMember_birth());
				pstmt.setString(5, memberbean.getMember_phone());
				pstmt.setString(6, memberbean.getMember_post());
				pstmt.setString(7, memberbean.getMember_address());
				pstmt.setString(8, memberbean.getMember_address2());
				pstmt.setString(9, memberbean.getMember_address3());
				pstmt.setString(10, memberbean.getMember_email());
				
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				System.out.println("insertMember메소드 오류");
				e.printStackTrace();
			} finally {
				CloseDB();
			}
		} // insertMember()
		
		

		public int idCheck(String member_id){
			int check = 0;
			
			try {

				con = getConnection();

				sql = "select * from member where member_id=?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, member_id);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					check = 1;
				}else{
					check = 0;
				}
			} catch (Exception e) {
				System.out.println("idCheck()메소드 오류");
			} finally {
				CloseDB();
			}//finally
			

			return check;
			
		}//idCheck()
		
		
		public ArrayList listMembers(){
			
			ArrayList<MemberBean> list = new ArrayList<MemberBean>();
			
			try{
				
				con = getConnection();
				
				sql = "select * from member order by 1";
				
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				
				while (rs.next()) {
					
					String member_id = rs.getString("member_id");
					String member_pw = rs.getString("member_pw");
					String member_name = rs.getString("member_name");
					String member_birth = rs.getString("member_birth");
					String member_phone = rs.getString("member_phone");
					String member_post = rs.getString("member_post");
					String member_address = rs.getString("member_address");
					String member_address2 = rs.getString("member_address2");
					String member_address3 = rs.getString("member_address3");
					String member_email = rs.getString("member_email");
					
					MemberBean vo = new MemberBean();
					vo.setMember_id(member_id);
					vo.setMember_pw(member_pw);
					vo.setMember_name(member_name);
					vo.setMember_birth(member_birth);
					vo.setMember_phone(member_phone);
					vo.setMember_post(member_post);
					vo.setMember_address(member_address);
					vo.setMember_address2(member_address2);
					vo.setMember_address3(member_address3);
					vo.setMember_email(member_email);
					
					list.add(vo);
					
				}//while
				
				
			} catch (Exception e) {
				System.out.println("listMembers메소드 오류");
			} finally {
				CloseDB();
			}
			
			return list;
			
		}//listMembers
		
		
		public int deleteMember(String member_id) {
			int check = 0;
			try {
				con = getConnection();
				sql = "select member_id from member where member_id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, member_id);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					if(member_id.equals(rs.getString("member_id"))){
						check = 1;
						sql = "delete from member where member_id=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, member_id);
						
						pstmt.executeUpdate();
					} else {
						check = 0;
					}
				}
			} catch (Exception e) {
				System.out.println("deleteMember메소드 오류");
			} finally {
				CloseDB();
			}
			
			return check;
			
		} // deleteMember
		
		
		public int updateMember(MemberBean mBean, String member_pw_n) {
			int check = 0;

			try {
				if(member_pw_n.equals("")) return -1;
				
				con = getConnection();

				sql = "select member_pw from member where member_id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mBean.getMember_id());
				rs = pstmt.executeQuery();

				if(rs.next()){
					if(mBean.getMember_pw().equals(rs.getString("member_pw"))){
						check = 1;
						sql = "update member"
								+ " set member_pw=?, member_name=?, member_birth=?, member_phone=?, member_post=?,"
								+ "member_address=?, member_address2=?, member_address3=?, member_email=?"
								+ " where member_id=?";
						
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, member_pw_n);
						pstmt.setString(2, mBean.getMember_name());
						pstmt.setString(3, mBean.getMember_birth());
						pstmt.setString(4, mBean.getMember_phone());
						pstmt.setString(5, mBean.getMember_post());
						pstmt.setString(6, mBean.getMember_address());
						pstmt.setString(7, mBean.getMember_address2());
						pstmt.setString(8, mBean.getMember_address3());
						pstmt.setString(9, mBean.getMember_email());
						pstmt.setString(10, mBean.getMember_id());
						pstmt.executeUpdate();	
					}else{
						check = 0;
					}
				}		
			} catch (Exception e) {
				System.out.println("updateMember메소드 오류");
			    e.printStackTrace();
			}finally {
				CloseDB();				
			}
			return check;
		} // updateMember
		
		

		public MemberBean findMember(String member_id) {
			MemberBean bean = null;
			try {
				con = getConnection();
				
				sql = "select * from member where member_id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, member_id);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					bean = new MemberBean();
					
					bean.setMember_id(rs.getString("member_id"));
					bean.setMember_pw(rs.getString("member_pw"));
					bean.setMember_name(rs.getString("member_name"));
					bean.setMember_birth(rs.getString("member_birth"));
					bean.setMember_phone(rs.getString("member_phone"));
					bean.setMember_post(rs.getString("member_post"));
					bean.setMember_address(rs.getString("member_address"));
					bean.setMember_address2(rs.getString("member_address2"));
					bean.setMember_address3(rs.getString("member_address3"));
					bean.setMember_email(rs.getString("member_email"));
				}

				
			} catch (Exception e) {
				System.out.println("findMember메소드 오류");
			} finally {
				CloseDB();
			}
			
			return bean;
			
		} // findMember
}
