<%@page import="java.io.File"%>
<%@page import="gallery.GalleryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("UTF-8");

	//session값 얻기
	String member_id = (String)session.getAttribute("member_id");

	//session값이 저장되어 있지 않다면..login.jsp로 이동
	if(member_id == null){
		response.sendRedirect("../member/login.jsp");
	}
	

	String gallery_img_name = request.getParameter("gallery_img_name");
	
	ServletContext ctx = getServletContext();
	String realFolder = ctx.getRealPath("/gallery/upload");
	
	
	GalleryDAO dao = new GalleryDAO();
	dao.deletePicture(gallery_img_name);
	
	File file = new File(realFolder, gallery_img_name);
	file.delete();
	
	response.sendRedirect("../gallery.jsp");
 
%>