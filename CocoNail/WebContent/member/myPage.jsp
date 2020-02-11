
<%@page import="member.MemberDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.MemberBean"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");
	
	MemberDAO memberdao = new MemberDAO();
 %>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>myPage - Coco Nail</title>
	<link rel="stylesheet" href="../css/style.css" type="text/css">
	<link rel="stylesheet" href="../css/login.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="../css/mobile.css">
	<script src="../js/mobile.js" type="text/javascript"></script>
	
	<script type="text/javascript">
		function check() {
			var form = document.fr; //폼이름
	 
			if(form.member_pw.value == "") {
				alert("비밀번호는 필수입력입니다.");
				form.member_pw.focus();
				return ;
			} else if (form.member_pw.value.length < 8 || form.member_pw.value.length > 20) {
				alert("비밀번호는 8자~20자 이내로 입력하세요.");
				form.member_pw.value="";
				form.member_pw.focus();
				return ;
			} else if(form.member_pw_n.value == "") {
				alert("새 비밀번호를 입력하세요.");
				form.member_pw_n.focus();
			} else if(form.member_pw2.value == "") {
				alert("비밀번호 확인은 필수입력입니다.");
				form.member_pw2.focus();
				return ;
			} else if (form.member_pw_n.value != form.member_pw2.value) {
				alert("비밀번호가 다릅니다.");
				form.member_pw2.value="";
				form.member_pw2.focus();
				return ;
			} else if(form.member_name.value == "") {
				alert("이름은 필수입력입니다.");
				form.member_name.focus();
				return ;
			} else if(form.member_name.value.length < 2 || form.member_name.value.length > 7) {
				alert("이름은 2자~7자 이내로 작성하세요.");
				form.member_name.value="";
				form.member_name.focus();
				return ;
			} else if(form.member_phone.value == "") {
				alert("전화번호는 필수입력입니다.");
				form.member_phone.focus();
				return ;
			} else if(form.member_phone.value.length != 11) {
				alert("전화번호는 11자로 입력하세요.");
				form.member_phone.value="";
				form.member_phone.focus();
				return ;
			} else if(form.member_post.value == "") {
				alert("우편번호는 필수입력입니다.");
				form.member_postBtn.focus();
				return ;
			} else if(form.member_address.value == "") {
				alert("주소는 필수입력입니다.");
				form.member_address.focus();
				return ;
			} else if(form.member_address2.value == "") {
				alert("주소는 필수입력입니다.");
				form.member_address2.focus();
				return ;
			} else if(form.member_address2.value == "") {
				alert("상세주소는 2자~45자 이내로 입력하세요.");
				form.member_address2.focus();
				return ;
			} else if(form.member_address3.value == "") {
				alert("주소는 필수입력입니다.");
				form.member_address3.focus();
				return ;
			} else {
				//빈값이 없을 경우에 다음 페이지 이동을 합니다.
				form.action = "myPagePro.jsp"; //다음페이지 주소
				form.submit(); // 폼 실행
			}
		}
	</script>
	
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample6_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample6_postcode').value = data.zonecode;
	                document.getElementById("sample6_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("sample6_detailAddress").focus();
	            }
	        }).open();
	    }
	</script>
	
</head>
<body>
	<div id="page">
		<div id="header">
			<div>
			<%
				//session객체영역에 세션값을 얻어...
				String member_id = (String)session.getAttribute("member_id");
				MemberBean mbean = memberdao.findMember(member_id);
				
				
				//session객체 영역에 세션id값이 저장되어 있지 않다면?
				if(member_id == null){ //로그아웃된 상태의 화면을 보여 주자 
			%>		
				<div id="login">
					<a href="login.jsp">login</a>
					<a href="join.jsp">join</a>
				</div>
			<%		
				}else{//session객체 영역에 세션id값이 저장되어 있다면?
			%>	
				<div id="login">
			<%
				if(member_id.equals("admin")) {
			%>
					<a href="admin.jsp">admin</a>
					<a href="logout.jsp">logout</a>
			<%
				} else {
			%>
					<a href="myPage.jsp">myPage</a>
					<a href="logout.jsp">logout</a>
			<%  }	%>
				</div>
			<%			
				}
			%>
			
			</div>
			<div id="logo">
				<a href="../index.jsp" class="logo"><img src="../img/title/logo3.png" alt=""></a>
				<ul id="navigation">
					<li class="selected">
						<a href="../index.jsp">Home</a>
					</li>
					<li class="menu">
						<a href="../about.jsp">About</a>
						<ul class="primary">
							<li>
								<a href="../gallery.jsp">Gallery</a>
							</li>
						</ul>
					</li>
					<li class="menu">
						<a href="../book.jsp">Book</a>
						<ul class="secondary">
							<li>
								<a href="../price.jsp">Price</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="../review.jsp">Review</a>
					</li>
				</ul>
			</div>
		</div>
		<div id="body">
			<div class="header">
				<div>
					<h1>myPage</h1>
				</div>
			</div>
			<div class="body">
				<img src="../img/t_1_r.jpg" alt="" width="1200px" height="249px">
			</div>
			<div class="footer">
				<div class="sidebar">
					<h1>Coco Nail</h1>
					<p>Hello ^_^<br>This is the member information edit page.<br> Please enter your<br> new information.<br></p>
				</div>
				<div class="article">
					<h1>myPage</h1>
					<form action="myPagePro.jsp" id="join" method="post" name="fr">
						<fieldset>
							<label>User ID</label> <input type="text" name="member_id" value="<%=member_id %>" readonly><br>
							<label>Password</label> <input type="password" name="member_pw" value=""><br>
							<label>New Password</label> <input type="password" name="member_pw_n"><br>
							<label>Retype Password</label> <input type="password" name="member_pw2"><br>
							<label>Name</label> <input type="text" name="member_name" value="<%=mbean.getMember_name() %>"><br>
							<label>Birth</label> <input type="text" name="member_birth" value="<%=mbean.getMember_birth() %>"><br>
							<label>Phone</label> <input type="text" name="member_phone" value="<%=mbean.getMember_phone() %>"><br>
							<label>Post</label> <input type="text" name="member_post" id="sample6_postcode" value="<%=mbean.getMember_post() %>">
							<input type="button" class="btn" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
							<label>Address</label> <input type="text" name="member_address" id="sample6_address" value="<%=mbean.getMember_address() %>"><br>
							<label>&nbsp;</label> <input type="text" name="member_address2" id="sample6_detailAddress" value="<%=mbean.getMember_address2() %>"><br>
							<label>&nbsp;</label> <input type="text" name="member_address3" id="sample6_extraAddress" value="<%=mbean.getMember_address3() %>"><br>
							<label>E-Mail</label> <input type="email" name="member_email" value="<%=mbean.getMember_email() %>"><br>
						</fieldset>
						<label>&nbsp;</label><label>&nbsp;</label>
						<input type="button" value="회원탈퇴" class="btn" onclick="myPageDel();">
						<div class="clear"></div>
						<div id="buttons">
							<input type="button" value="저장" class="submit" onclick="check();">
							<input type="reset" value="취소" class="cancel">
						</div>
					</form>
					
				</div>
			</div>
		</div>
		<div id="footer">
			<jsp:include page="../inc/bottom.jsp"/>
		</div>
	</div>
	
	<script type="text/javascript">
		function myPageDel() {
			var member_pw = document.fr.member_pw.value;
			
			if(member_pw == <%= mbean.getMember_pw()%>) {
				if(confirm('탈퇴하시겠습니까?')){
					location.href="myPageDel.jsp?member_id=<%=member_id %>";
				} else {
					alert('회원탈퇴 취소');
				}
			} else {
				alert('비밀번호가 맞지 않습니다.');
			}
		}
	</script>
</body>
</html>