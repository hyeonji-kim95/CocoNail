<%@page import="java.util.List"%>
<%@page import="gallery.GalleryBean"%>
<%@page import="gallery.GalleryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!doctype html>
<!-- Website template by freewebsitetemplates.com -->
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Gallery - Coco Nail</title>
	<link rel="stylesheet" href="css/style.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="css/mobile.css">
	<link rel="stylesheet" href="css/gallery.css" type="text/css">
	<script src="js/mobile.js" type="text/javascript"></script>


<%

	GalleryDAO galleryDAO = new GalleryDAO();
	int count = galleryDAO.getgalleryCount(); // gallery에 사진이 몇개가 있는지
	int gallery_num = 0;
	String path = request.getParameter("path");
%>
	
</head>
<body>
	<div id="page">
		<div id="header">
			<jsp:include page="inc/top.jsp"/>
		</div>
		<div id="body">
			<div class="header">
				<div>
					<h1>gallery</h1>
				</div>
			</div>
			<div class="gallery_po_div">
		<%
			String member_id = (String)session.getAttribute("member_id");
			
			if(member_id == null){
				response.sendRedirect("member/login.jsp");
			}
		
			List<GalleryBean> list = null;
			
			if(count > 0) {
				list = galleryDAO.getRGalleryList();
				for(int i = 0; i < list.size(); i++) {
					GalleryBean bean = list.get(i);
					String gallery_img_name = bean.getGallery_img_name();
		%>
					<div class="gallery_po">
						<img src="<%=bean.getGallery_img() %>" alt="img" width="500px" height="500px" onclick="BigPic('<%=gallery_img_name%>');"><br>
						<span class="pa">like</span> 
						<%= bean.getGallery_like() %>
						<img src="img/gallery/likeP.png" alt="like" id="like" onclick="likeBtn('<%=bean.getGallery_num()%>');" width="20px"><span><% galleryDAO.getLike(bean.getGallery_num()); %></span>
						<span class="spa"></span>
			<%		if(member_id != null && member_id.equals("admin")) { %>
						<input type="button" value="delete" class="bo" onclick="delPic('<%=bean.getGallery_img_name()%>');">
			<%		} %>
					</div>
			<%  }
			   } else { %>
				<p>gallery 사진이 없습니다.</p>
			<% } %>
			</div>
			
			<%
			  if(member_id != null && member_id.equals("admin")) {
			%>
				<div class="clear"><input type="submit" value="upload" class="butn" onclick="location.href='gallery/upload.jsp'"></div>
			<% } %>
		</div>
		<div id="footer">
			<div>
				<div class="connect">
					<a href="https://www.facebook.com/"><img src="img/footer/facebook.png" width="30" height="30" id="facebook"></a>
					<a href="https://www.instagram.com/"><img src="img/footer/instagram.png" width="30" height="30" id="instagram"></a>
					<a href="https://twitter.com/"><img src="img/footer/twitter.png" width="30" height="30" id="twitter"></a>
					<a href="mailto:coco_nail@style.com"><img src="img/footer/outlook.png" width="30" height="30" id="gmail"></a>
				</div>
				<p>
					<span>address</span>&nbsp;&nbsp; 서울 강남구 청담동 ○○-○○번지<br>
				    <span>contact</span>&nbsp;&nbsp; coco_nail@style.com \ 02-123-4567<br>
				    <span>service</span>&nbsp;&nbsp; AM 10:00 - PM 8:00<br>
				</p>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		function likeBtn(gallery_num) {
			location.href="gallery/galleryPro.jsp?gallery_num=" + gallery_num;
		}
		
		function delPic(gallery_img_name) {
			location.href="gallery/deleteGal.jsp?&gallery_img_name=" + gallery_img_name;
		}
		function BigPic(gallery_img_name) {
			window.open("gallery/BigPic.jsp?gallery_img_name=" + gallery_img_name, "", "width=880, height=880");
		}
	</script>
	
</body>
</html>
    