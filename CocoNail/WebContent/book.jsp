<%@page import="book.BookDAO"%>
<%@page import="book.BookCalendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<!-- Website template by freewebsitetemplates.com -->
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Book - Coco Nail</title>
	<link rel="stylesheet" href="css/style.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="css/mobile.css">
	<script src="js/mobile.js" type="text/javascript"></script>
	
	<style type="text/css">
		table {background-color: #FFF0F5;}
		tr{height: 60px;}
		td{width: 100px; text-align: right; font-size: 15pt; font-family: D2coding;}
	/* 타이틀 스타일 */
		th#title {font-size: 20pt; font-weight: bold; color: #505050; font-family: D2coding; }
	
	/* 요일 스타일 */
		td.sunday{ text-align: center; font-weight: bold; color: red; font-family: D2coding; }
		td.saturday{ text-align: center; font-weight: bold; color: blue; font-family: D2coding; }
		td.etcday{ text-align: center; font-weight: bold; color: black; font-family: D2coding; }
	
	/* 날짜 스타일 */
		td.sun{ text-align: right; font-size: 15pt; color: red; font-family: D2coding; vertical-align: top;}
		td.sat{ text-align: right; font-size: 15pt; color: blue; font-family: D2coding; vertical-align: top;}
		td.etc{ text-align: right; font-size: 15pt; color: black; font-family: D2coding; vertical-align: top;}
		
		td.redbefore{ text-align: right; font-size: 12pt; color: red; font-family: D2coding; vertical-align: top;}
		td.before{ text-align: right; font-size: 12pt; color: gray; font-family: D2coding; vertical-align: top;}
		
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
		
		.bo {
			height: 25px;
 			width: 70px;
			border: 1px solid #666;
			border-radius:2px;
			box-shadow:3px 3px 2px #CCC;
			font-size: 14px;
			background-color: #ffffff;
			margin: 0 0 0 20px;
			background-repeat: repeat-x;
			background-position: center center;
			color: #5A5A5A;
		}
		
	</style>
	
</head>
<%
			String member_id = (String)session.getAttribute("member_id");
			
			if(member_id == null){
				response.sendRedirect("member/login.jsp");
			}
%>
<body>
	<div id="page">
		<div id="header">
			<jsp:include page="inc/top.jsp"/>
		</div>
		<div id="body">
			<div class="header">
				<div>
					<h1>Book</h1>
				</div>
			</div>
			<div class="book">
				<div>
			<%
					Date date = new Date();
					int year = date.getYear() + 1900;
					int month = date.getMonth() + 1;
					
					
					try {
						if(request.getParameter("year") != null && request.getParameter("month") != null) {
							year = Integer.parseInt(request.getParameter("year"));
							month = Integer.parseInt(request.getParameter("month"));
						} else {
							year = year;
							month = month;
						}
						

						if(month >= 13) {
							year++;
							month = 1;
						} else if(month <= 0) {
							year--;
							month=12;
						}
					} catch (Exception e) {
						System.out.println("book.jsp 104번줄" + e);
						e.printStackTrace();
					}
					
			%>
					<p>
						* 예약은 최소 하루 전에 진행해주세요.
				<%	if(member_id != null && !member_id.equals("admin")) { %>
							<input type="button" class="bo" value="MyBook" onclick="Mybook();" style="float: right; margin-right: 40px;">
				<%	} %>
					</p>
					<table width="900" height="700" align="center" border="1" cellpadding="5" cellspacing="0">
						<tr>
							<th>
								<input type="button" value="이전 달" class="butn" onclick="location.href='book.jsp?year=<%=year%>&month=<%=month-1%>'">
							</th>
							<th id="title" colspan="5"><%=year %>년 <%=month %>월</th>
							<th>
								<input type="button" value="다음 달" class="butn" onclick="location.href='book.jsp?year=<%=year%>&month=<%=month+1%>'">
							</th>
						</tr>
						<tr>
							<td class="sunday">일</td>
							<td class="etcday">월</td>
							<td class="etcday">화</td>
							<td class="etcday">수</td>
							<td class="etcday">목</td>
							<td class="etcday">금</td>
							<td class="saturday">토</td>
						</tr>
						<tr>
						<%
							int first = BookCalendar.weekDay(year, month, 1);
							
							int start = 0;
							start = month == 1? BookCalendar.lastDay(year-1, 12)-first:BookCalendar.lastDay(year, month-1)- first;
							
							for(int i = 1; i<= first; i++) {
								if(i == 1) {
									out.println("<td class = 'redbefore'>"+(month ==1? 12 : month-1)+"/"+ ++start +"</td>");
								} else {
									out.println("<td class = 'before'>"+(month ==1? 12 : month-1)+"/"+ ++start +"</td>");
								}
							}
							
							for(int i = 1; i <= BookCalendar.lastDay(year, month); i++) {
								switch(BookCalendar.weekDay(year, month, i)) {
									case 0:
										out.println("<td class='sun'>" + i);
										out.println("<br><input type='button' class='bo' value='booking' onclick='booking(" + i + ");'></td>");
										break;
									case 6:
										out.println("<td class='sat'>" + i);
										out.println("<br><input type='button' class='bo' value='booking' onclick='booking(" + i + ");'></td>");
										break;
									default:
										out.println("<td class='etc'>" + i);
										out.println("<br><input type='button' class='bo' value='booking' onclick='booking(" + i + ");'></td>");
										break;
								} // switch

								

								if(BookCalendar.weekDay(year, month, i) == 6 && i != BookCalendar.lastDay(year, month)) {
									out.println("</tr><tr>");
								}
							} // for문
							if(BookCalendar.weekDay(year, month, BookCalendar.lastDay(year, month)) != 6) {
								for(int i = BookCalendar.weekDay(year, month, BookCalendar.lastDay(year, month)) + 1; i < 7; i++) {
									out.println("<td></td>");
								}
							}
							
						%>
						</tr>
					</table>
				</div>
			</div>
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
		// 예약자 아이디
		var member_id = '<%= member_id%>';
		
		// 예약버튼 클릭시 실행되는 함수
		function booking(i) {
			// 선택한 날짜
			var book_date = '<%=year%>' + "/" + '<%=month%>' + "/" + i;
			
			var year = '<%=year%>';
			var month = '<%=month%>';
			
			var d = new Date();

			if(member_id != "admin") {
				// 오늘날짜와 같거나 작으면 예약할 수 없습니다 메세지 출력
				
				if(year < d.getFullYear()) {
					alert("예약이 불가능한 날짜입니다.");
				} else if(month < d.getMonth()+1) {
					alert("예약이 불가능한 날짜입니다.");
				} else if(i <= d.getDate() && month <= d.getMonth()+1) {
					alert("예약이 불가능한 날짜입니다.");
				} else {
					// 새창 띄워서 거기서 예약 진행
					window.open("book/booking.jsp?member_id=" + member_id +"&book_date=" + book_date,"","width=1000,height=500");
				}
			} else { // 관리자면 모든 버튼 활성화 -> 새창에서 해당 날짜의 예약내역 볼 수 있음
				window.open("book/adminBook.jsp?book_date=" + book_date,"","width=1000,height=500");
			}
			
		}
		
		
		// 예약 확인 버튼 클릭시 실행되는 함수
		function Mybook() {
			window.open("book/Mybook.jsp?member_id=" + member_id, "", "width=700, height=500");
		}
		
	</script>
</body>
</html>
    