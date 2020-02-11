package book;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class BookDAO {

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";	


	private Connection getConnection() throws Exception {

		Context init = new InitialContext();

		DataSource ds = 
				(DataSource)init.lookup("java:comp/env/jdbc/coco");

		con = ds.getConnection();
		System.out.println("DB연결 성공");
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
	
	public int bookTimeChk(String book_date) {
		int check = 0;
		try {
			con = getConnection();
			
			sql = "select count(*) from book where book_date=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, book_date);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getInt("count(*)") == 1) {
					check = 1;
				}
				if(rs.getInt("count(*)") == 2) {
					check = 2;
				}
			}
			
		} catch (Exception e) {
			System.out.println("bookTimeChk메소드 오류");
		} finally {
			CloseDB();
		}
		
		return check;
	} // bookTimeChk메소드
	
	
	public String getBookTime(String book_date) {
		String book_time = null;
		try {
			con = getConnection();
			
			sql = "select book_time from book where book_date=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, book_date);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				book_time = rs.getString("book_time");
			}
		} catch (Exception e) {
			System.out.println("getBookTime메소드 오류");
		} finally {
			CloseDB();
		}
		
		return book_time;
	} // getBookTime메소드
	
	
	public String getBookStatus(String book_date) {
		String book_status = null;
		try {
			con = getConnection();
			
			sql = "select book_status from book where book_date=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, book_date);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				book_status = rs.getString("book_status");
			}
		} catch (Exception e) {
			System.out.println("getBookStatus메소드 오류");
		} finally {
			CloseDB();
		}
		
		return book_status;
	} // getBookStatus메소드
	
	
	public void insertBook(BookBean bookBean) {
		try {
			con = getConnection();

			sql = "insert into book(member_id, book_date, book_time, book_sub) "
				+ "values(?, ?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, bookBean.getMember_id());
			pstmt.setString(2, bookBean.getBook_date());
			pstmt.setString(3, bookBean.getBook_time());
			pstmt.setString(4, bookBean.getBook_sub());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("insertBook메소드 오류");
			e.printStackTrace();
		} finally {
			CloseDB();
		}
	} // insertBook메소드
	
	
	public ArrayList listBooks(String member_id){
		
		ArrayList<BookBean> list = new ArrayList<BookBean>();
		
		try{
			
			con = getConnection();
			
			sql = "select * from book where member_id=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			
			rs = pstmt.executeQuery();
			
			
			while (rs.next()) {
				int book_num = rs.getInt("book_num");
				String book_date = rs.getString("book_date");
				String book_time = rs.getString("book_time");
				String book_sub = rs.getString("book_sub");
				String book_status = rs.getString("book_status");

				
				BookBean vo = new BookBean();
				vo.setBook_num(book_num);
				vo.setMember_id(member_id);
				vo.setBook_date(book_date);
				vo.setBook_time(book_time);
				vo.setBook_sub(book_sub);
				vo.setBook_status(book_status);
				
				list.add(vo);
				
			}//while
			
			
		} catch (Exception e) {
			System.out.println("listBooks메소드 오류");
		} finally {
			CloseDB();
		}
		
		return list;
		
	}//listBooks메소드
	
	
	public void bookCancle(int book_num) {
		try {
			con = getConnection();
			sql = "delete from book where book_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, book_num);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("bookCancle메소드 오류");
		} finally {
			CloseDB();
		}
	} // bookCancle메소드
	
	
	public ArrayList todayBooking(String book_date){
		ArrayList<bBean> list = new ArrayList<bBean>();
		
		try{
			con = getConnection();
			sql = "select m.member_id, m.member_name, m.member_phone, b.book_num, b.book_time, b.book_sub, b.book_status"
					+ " from member m join book b"
					+ " on m.member_id = b.member_id"
					+ " where book_date = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, book_date);
			
			rs = pstmt.executeQuery();
			
			
			while (rs.next()) {
				String member_id = rs.getString("member_id");
				String member_name = rs.getString("member_name");
				String member_phone = rs.getString("member_phone");
				int book_num = rs.getInt("book_num");
				String book_time = rs.getString("book_time");
				String book_sub = rs.getString("book_sub");
				String book_status = rs.getString("book_status");
				
				
				
				bBean vo = new bBean();
				vo.setMember_id(member_id);
				vo.setMember_name(member_name);
				vo.setMember_phone(member_phone);
				vo.setBook_num(book_num);
				vo.setBook_date(book_date);
				vo.setBook_time(book_time);
				vo.setBook_sub(book_sub);
				vo.setBook_status(book_status);
				
				list.add(vo);
				
			}//while
			
			
		} catch (Exception e) {
			System.out.println("todayBooking메소드 오류");
		} finally {
			CloseDB();
		}
		
		return list;
		
	}//todayBooking메소드
	
	
	public void DoneBook(int book_num) {
		try {
			con = getConnection();
			sql = "update book set book_status='done' where book_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, book_num);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("DoneBook메소드 오류");
		} finally {
			CloseDB();
		}
	} // DoneBook메소드
	
	
	public void delAllBook(String member_id) {
		try {
			con = getConnection();
			sql = "select book_num from book where member_id=? and book_status='book'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int book_num = rs.getInt("book_num");
				
				sql = "delete from book where book_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, book_num);
				pstmt.executeUpdate();
				
			}
			
		} catch (Exception e) {
			System.out.println("delAllBook메소드 오류");
		} finally {
			CloseDB();
		}
	} // delAllBook
	
}
