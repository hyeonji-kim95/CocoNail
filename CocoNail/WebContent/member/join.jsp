<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!doctype html>
<!-- Website template by freewebsitetemplates.com -->
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Join - Coco Nail</title>
	<link rel="stylesheet" href="../css/style.css" type="text/css">
	<link rel="stylesheet" href="../css/login.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="../css/mobile.css">
	<script src="../js/mobile.js" type="text/javascript"></script>
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
		var idch = 0;

 		function winopen() {
 			var member_id = document.fr.member_id.value;
 			if(member_id == "") { // 아이디를 입력 하지 않았다면
 				alert("아이디를 입력하세요");
 				// 아이디 입력란에 포커스 깜빡
 				document.fr.member_id.focus();
 				return;
 			} else {
				$.ajax({
					type: "post",
					dataType: "text",
					async: false,
					url: "/CocoNail/mem",
					data: {member_id:member_id},
					
					success: function(data, textStatus) { // 요청에 성공했을 때 data변수로 서블릿이 응답한 응답값을 전달받음
						if(data == 'usable') {
							$("#idch").text("사용가능");
 							$(".member_id").attr("readonly", "readonly");
							idch = "1";
						} else {
							$("#idch").text("사용불가");
							document.fr.member_id.focus();
						}
					}
				
				});
 			}
		}
		
		function check() {
 			var form = document.fr; //폼이름
		 
 			if(form.member_id.value == "") {
				alert("아이디는 필수입력입니다.");
				form.member_id.focus();
				return ;
	 		} else if(form.member_pw.value == "") {
				alert("비밀번호는 필수입력입니다.");
				form.member_pw.focus();
				return ;
			} else if (form.member_pw.value.length < 8 || form.member_pw.value.length > 20) {
				alert("비밀번호는 8자~20자 이내로 입력하세요.");
				form.member_pw.value="";
				form.member_pw.focus();
				return ;
			} else if(form.member_pw2.value == "") {
				alert("비밀번호 확인은 필수입력입니다.");
				form.member_pw2.focus();
				return ;
			} else if (form.member_pw.value != form.member_pw2.value) {
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
				if(idch == "0") {
					alert("아이디 중복 체크를 해주세요.");
					return ;
				} else {
					//빈값이 없을 경우에 다음 페이지 이동을 합니다.
					form.action = "joinPro.jsp"; //다음페이지 주소
					form.submit(); // 폼 실행
				}
			}
		}
		
		function checkPasswd() {
			var pwch = document.getElementById("pwch");
			if(document.fr.member_pw.value != document.fr.member_pw2.value) {
				pwch.innerHTML = "&nbsp;&nbsp;&nbsp;<img src='../img/join/close.png' width='14px'> 비밀번호가 다릅니다.";
			} else {
				pwch.innerHTML = "&nbsp;&nbsp;&nbsp;<img src='../img/join/check.png' width='15px'> 비밀번호가 같습니다.";
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
				//session객체영역에 세션id값을 얻어...
				String member_id = (String)session.getAttribute("member_id");
				
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
					<h1>Join</h1>
				</div>
			</div>
			<div class="body">
				<img src="../img/t_4_r2.jpg" alt="" width="1200px" height="249px">
			</div>
			<div class="footer">
				<div class="sidebar">
					<h1>Welcome</h1>
					<p>Hello ^_^<br>This is join page.<br> Please enter your information on the right.<br> If you are a member,<br> <a href="login.jsp">login</a> now.</p>
				</div>
				<div class="article">
					<h1>Join</h1>
					<form action="joinPro.jsp" id="join" method="post" name="fr">
						<fieldset>
							<p>
							*은 필수 입력사항입니다.<br>
							비밀번호는 8자~20자 이내로 입력하세요.<br>
							생년월일 ex)951109 / 휴대폰 번호는 숫자로만 입력하세요(11자리)
							</p>
							<label>* User ID</label> <input type="text" name="member_id" class="member_id" maxlength="15">
							<input type="button" value="ID중복체크" class="btn" onclick="winopen();"><span id="idch"></span><br>
							<label>* Password</label> <input type="password" name="member_pw"><br>
							<label>* Retype Password</label> <input type="password" name="member_pw2" onblur="checkPasswd();"><br>
							<span id="pwch"></span>
							<label>* Name</label> <input type="text" name="member_name"><br>
							<label>&nbsp;&nbsp;&nbsp;Birth</label> <input type="text" name="member_birth" maxlength="6"><br>
							<label>* Phone</label> <input type="text" name="member_phone" maxlength="11"><br>
							<label>* Post</label><input type="text" id="sample6_postcode" name="member_post">
							<input type="button" class="btn" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" name="member_postBtn"><br>
							<label>* Address</label><input type="text" id="sample6_address" name="member_address"><br>
							<label>&nbsp;</label><input type="text" id="sample6_detailAddress" placeholder="상세주소" name="member_address2" maxlength="30"><br>
							<label>&nbsp;</label><input type="text" id="sample6_extraAddress" placeholder="참고항목" name="member_address3"><br>
							<label>&nbsp;&nbsp;&nbsp;E-Mail</label> <input type="email" name="member_email" maxlength="40"><br>
						</fieldset>
						<div class="clear"></div>
						<div id="buttons">
							<input type="button" value="회원가입" class="submit" onclick="check();">
							<input type="reset" value="가입취소" class="cancel">
						</div>
					</form>
				</div>
			</div>
		</div>
		<div id="footer">
			<jsp:include page="../inc/bottom.jsp"/>
		</div>
	</div>
</body>
</html>