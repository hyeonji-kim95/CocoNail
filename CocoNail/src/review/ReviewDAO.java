package review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class ReviewDAO {
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
		
		
		public int getreviewCount() {
			int count = 0;
			
			try {
				con = getConnection();
				sql = "select count(*) from review";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					count = rs.getInt(1);
				}
			
			} catch (Exception e) {
				System.out.println("getreviewCount메소드 오류");
			} finally {
				CloseDB();
			}
			
			return count;
		} // getreviewCount메소드
		
		
		public List<ReviewBean> getReviewList(int startRow,int pageSize){
			
			List<ReviewBean> reviewList = new ArrayList<ReviewBean>();
			
			try{
				con = getConnection();
				sql = "select * from review order by re_ref desc, re_seq asc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					ReviewBean rBean = new ReviewBean();

					rBean.setReview_num(rs.getInt("review_num"));
					rBean.setMember_id(rs.getString("member_id"));
					rBean.setReview_subject(rs.getString("review_subject"));
					rBean.setReview_content(rs.getString("review_content"));
					rBean.setReview_file(rs.getString("review_file"));
					rBean.setRe_ref(rs.getInt("re_ref"));
					rBean.setRe_lev(rs.getInt("re_lev"));
					rBean.setRe_seq(rs.getInt("re_seq"));
					rBean.setReview_date(rs.getTimestamp("review_date"));
					rBean.setReview_readcount(rs.getInt("review_readcount"));
					rBean.setReview_re(rs.getInt("review_re"));
					

					reviewList.add(rBean);

				}//while
				
			}catch(Exception err){
				System.out.println("getReviewList메소드 오류");
			}finally {
				CloseDB();
			}
			
			return reviewList;
		} // getReviewList메소드
		
		
		public void insertReview(ReviewBean rBean){		
			int num = 0;
			try{
				con = getConnection();

				sql = "select max(review_num) from review";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					num = rs.getInt(1) + 1;
				}else{
					num = 1;
				}
				//insert
				sql = "insert into review"
					+ "(review_num, member_id, review_subject, review_content, review_file,"
					+ "re_ref,re_lev, re_seq, review_date, review_readcount, review_re) "
					+ "values(?,?,?,?,?,?,?,?,?,?,?)";
 
				pstmt = con.prepareStatement(sql);

				pstmt.setInt(1, num);
				pstmt.setString(2, rBean.getMember_id());
				pstmt.setString(3, rBean.getReview_subject());
				pstmt.setString(4, rBean.getReview_content());
				pstmt.setString(5, rBean.getReview_file());
				pstmt.setInt(6, num);
				pstmt.setInt(7, 0);
				pstmt.setInt(8, 0);
				pstmt.setTimestamp(9, rBean.getReview_date());
				pstmt.setInt(10, 0);
				pstmt.setInt(11, 0);
				
				//insert
				pstmt.executeUpdate();
				
			}catch(Exception e){
				System.out.println("insertReview 오류" + e);
			}finally {
				CloseDB();
			}		
		} // insertReview메소드
		

		public void updateReadCount(int review_num){
			
			try {
				con = getConnection();
				
				sql = "update review set review_readcount=review_readcount+1 where review_num=?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, review_num);
				
				pstmt.executeUpdate();
			
			} catch (Exception e) {
				System.out.println("updateReadCount메소드 오류");
			} finally {
				CloseDB();
			}
				
		} // updateReadCount메소드
		
		
		public ReviewBean getReview(int review_num){
			
			ReviewBean reviewBean = null;
			
			try {
				con = getConnection();

				sql = "select * from review where review_num=?";

				pstmt = con.prepareStatement(sql);

				pstmt.setInt(1, review_num);

				rs = pstmt.executeQuery();
				
				if(rs.next()){
					
					reviewBean = new ReviewBean();
					
					reviewBean.setReview_num(rs.getInt("review_num"));
					reviewBean.setMember_id(rs.getString("member_id"));
					reviewBean.setReview_subject(rs.getString("review_subject"));
					reviewBean.setReview_content(rs.getString("review_content"));
					reviewBean.setReview_file(rs.getString("review_file"));
					reviewBean.setRe_ref(rs.getInt("re_ref"));
					reviewBean.setRe_lev(rs.getInt("re_lev"));
					reviewBean.setRe_seq(rs.getInt("re_seq"));
					reviewBean.setReview_date(rs.getTimestamp("review_date"));
					reviewBean.setReview_readcount(rs.getInt("review_readcount"));
					reviewBean.setReview_re(rs.getInt("review_re"));
					
				}
			
			} catch (Exception e) {		
				System.out.println("getReview메소드 오류");
			} finally {
				CloseDB();
			}
				
			return reviewBean;
			
		} // getReview메소드

		
		public int updateReview(ReviewBean rBean){
			int check = 0;
			
			try {
				con = getConnection();
				
				sql = "select member_id from review where review_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, rBean.getReview_num());
				rs = pstmt.executeQuery();
				if(rs.next()){
					if(rBean.getMember_id().equals(rs.getString("member_id")) || rBean.getMember_id().equals("admin")){
						check = 1;
						sql = "update review set review_subject=?, review_content=? where review_num=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, rBean.getReview_subject());
						pstmt.setString(2, rBean.getReview_content());
						pstmt.setInt(3, rBean.getReview_num());
						pstmt.executeUpdate();
					}else{
						check = 0;
					}
				}
			} catch (Exception e) {
				System.out.println("updateReview메소드 오류");
			}finally {
				CloseDB();			
			}
			return check;
		} // updateReview메소드
		

		public int deleteReview(int review_num){
			int check = 0;
			
			try{
				con = getConnection();
				sql = "select review_num from review where review_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, review_num);

				rs = pstmt.executeQuery();
				
				if(rs.next()){	
						check = 1;

						sql = "delete from review where review_num=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, review_num);
						pstmt.executeUpdate();
				} else {
					check = 0;
				}
			}catch(Exception err){
				System.out.println("deleteReview메소드 오류");
			}finally {
				CloseDB();	
			}
			return check;
		} // deleteReview
		
		

		public void updateReview_re(int review_num, String review_reContent) {
			try {
				con = getConnection();
				sql = "update review set review_reContent = ?, review_re = review_re+1 where review_num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, review_reContent);
				pstmt.setInt(2, review_num);
				
				pstmt.executeUpdate();
				
			} catch(Exception err){
				System.out.println("updateReview_re메소드 오류");
			} finally {
				CloseDB();	
			}
		} // updateReview_re메소드
		
		
		public String findReview_reContent(int review_num) {
			String review_reContent = "";
			
			try {
				con = getConnection();
				sql = "select review_reContent from review where review_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, review_num);
				rs = pstmt.executeQuery();
				
				if(rs.next())
					review_reContent = rs.getString("review_reContent");	
				
			} catch (Exception e) {
				System.out.println("findReview_reContent메소드 오류");
			} finally {
				CloseDB();
			}
			
			return review_reContent;
		} // findReview_reContent메소드
		
		
		
		public List<ReviewBean> findReviewContent(String keyword) {
			List<ReviewBean> reviewList = new ArrayList<ReviewBean>();
			
			try {
				con = getConnection();
				sql = "select * from review where review_subject like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyword+"%");
				
				rs = pstmt.executeQuery();
				while(rs.next()) {
					ReviewBean rBean = new ReviewBean();
					
					rBean.setReview_num(rs.getInt("review_num"));
					rBean.setMember_id(rs.getString("member_id"));
					rBean.setReview_subject(rs.getString("review_subject"));
					rBean.setReview_content(rs.getString("review_content"));
					rBean.setReview_file(rs.getString("review_file"));
					rBean.setRe_ref(rs.getInt("re_ref"));
					rBean.setRe_lev(rs.getInt("re_lev"));
					rBean.setRe_seq(rs.getInt("re_seq"));
					rBean.setReview_date(rs.getTimestamp("review_date"));
					rBean.setReview_readcount(rs.getInt("review_readcount"));
					rBean.setReview_re(rs.getInt("review_re"));
					

					reviewList.add(rBean);
					
					System.out.println(reviewList);
				}
				
			} catch (Exception e) {
				System.out.println("findReviewContent메소드 오류");
				e.printStackTrace();
			} finally {
				CloseDB();
			}
			
			
			return reviewList;
		} // findReviewContent메소드

}
