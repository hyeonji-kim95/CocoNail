package gallery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class GalleryDAO {
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
	
	public int getgalleryCount() {
		int count = 0;
		
		try {
			con = getConnection();
			sql = "select count(*) from gallery";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);
			}
		
		} catch (Exception e) {
			System.out.println("getgalleryCount메소드 오류");
		} finally {
			CloseDB();
		}
		
		return count;
	} // getreviewCount메소드
	
	
	public void PlusLike(int gallery_num) {
		try {
			con = getConnection();
			sql = "update gallery set gallery_like = gallery_like + 1 where gallery_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, gallery_num);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("PlusLike메소드 오류");
		} finally {
			CloseDB();
		}
	}
	

	public List<GalleryBean> getRGalleryList(){
		
		List<GalleryBean> galleryList = new ArrayList<GalleryBean>();
		
		try{
			con = getConnection();
			sql = "select * from gallery";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				GalleryBean gBean = new GalleryBean();
				
				gBean.setGallery_num(rs.getInt("gallery_num"));
				gBean.setGallery_img(rs.getString("gallery_img"));
				gBean.setGallery_img_name(rs.getString("gallery_img_name"));
				gBean.setGallery_like(rs.getInt("gallery_like"));

				galleryList.add(gBean);

			}//while
			
		}catch(Exception err){
			System.out.println("getGalleryList메소드 �뿉�윭");
		}finally {
			CloseDB();
		}
		
		return galleryList;
	} // getReviewList메소드
	
	
	public int getLike(int gallery_num) {
		int like = 0;
		try {
			con = getConnection();
			sql = "select gallery_like from gallery where gallery_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, gallery_num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				like = rs.getInt("gallery_like");
			}
		} catch (Exception e) {
			System.out.println("getLike메소드 오류");
		} finally {
			CloseDB();
		}
		
		return like;
		
	} // getLike메소드
	
	
	public void addPicture(String gallery_img, String gallery_img_name) {
		try {
			con = getConnection();
			sql = "insert into gallery values(null, ?, ?, 0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, gallery_img);
			pstmt.setString(2, gallery_img_name);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("addPicture메소드 오류");
		} finally {
			CloseDB();
		}
	} // addPicture메소드
	
	
	public void deletePicture(String gallery_img_name) {
		try {
			con = getConnection();
			sql = "delete from gallery where gallery_img_name = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, gallery_img_name);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("deletePicture메소드 오류");
		} finally {
			CloseDB();
		}
	} // deletePicture메소드
	
	
	
	
	

}
