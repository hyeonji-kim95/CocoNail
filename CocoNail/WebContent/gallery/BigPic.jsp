<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");
	
	String gallery_img_name = request.getParameter("gallery_img_name");
	String gallery_fod_img = "upload/" + gallery_img_name;
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=gallery_img_name %></title>
	<style type="text/css">
		.butn {
			height: 25px;
			width: 100px;
			border: 1px solid #666;
			border-radius:10px;
			box-shadow:3px 3px 2px #CCC;
			font-size: 14px;
			background-color: #FF7493;
			margin: 0 0 0 20px;
			background-repeat: repeat-x;
			background-position: center center;
			color: #ffffff;
		}
	</style>
	
	<script type="text/javascript">
		function Down(gallery_img_name) {
			location.href="downPic.jsp?path=upload&gallery_img_name=" + gallery_img_name;
		}
	</script>

</head>
<body>
	<div style="text-align: center;">
		<img src="<%=gallery_fod_img %>" alt="" width="865px" height="800px"><br><br>
		<input type="button" value="download" class="butn" onclick="Down('<%=gallery_img_name %>');">
	</div>
</body>
</html>

