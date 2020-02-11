<%@page import="gallery.GalleryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int gallery_num = Integer.parseInt(request.getParameter("gallery_num"));
	
	GalleryDAO dao = new GalleryDAO();
	
	dao.PlusLike(gallery_num);

	response.sendRedirect("../gallery.jsp");
%>