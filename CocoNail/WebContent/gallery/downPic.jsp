<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");
	
	// upload/이미지이름
	String gallery_img_name = request.getParameter("gallery_img_name");
	
	String path = request.getParameter("path");
	
	String realPath = getServletContext().getRealPath("/gallery/" + path);
	
	
	// ----------------------------------------------------------------
	
	response.setContentType("Application/x-msdownload");
	response.setHeader("Content-Disposition", "attachment;filename=" + gallery_img_name);
	
	File file = new File(realPath + "/" + new String(gallery_img_name.getBytes("8859_1"), "UTF-8"));
	
	byte[] data = new byte[1024];
	
	if(file.isFile()) {
		try {
			
			out.clear();
			out = pageContext.pushBody();
			
			BufferedInputStream input = new BufferedInputStream(new FileInputStream(file));
			
			BufferedOutputStream output = new BufferedOutputStream(response.getOutputStream());
			
			int read;
			
			while((read = input.read(data)) != -1) {
				output.write(data, 0, read);
			}
			
			output.flush();
			
			output.close();
			input.close();
			
		} catch (Exception e) {
			System.out.println("gallery/downPic.jsp 오류");
		}
	}

	
%>

<script>
	alert("다운로드 완료");
	history.go(-1);
</script>