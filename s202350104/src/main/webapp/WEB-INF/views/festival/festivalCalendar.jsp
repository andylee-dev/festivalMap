<%@page import="com.oracle.s202350104.model.FestivalsContent"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FestivalCalendar</title>
<style type="text/css">
	h2 {
	color: black;
	}
	
	h1 {
	font-size: 30px;
	}
	
	.fc-day-sun a {
 	 color: red;
  	text-decoration: none;
	}

	.fc-day-sat a {
  	color: blue;
  	text-decoration: none;
	}

</style>
 <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.9/index.global.min.js'></script>
   <script>
   document.addEventListener('DOMContentLoaded', function() {
       var calendarEl = document.getElementById('calendar');
       var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        navLinks: true,
        selectable: true, // 달력 일자 드래그 설정가능
        editable: true,  // 수정 가능
        droppable: true,
        dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
        locale: 'ko', // 한국어 설정
        events: [
        				<%List<FestivalsContent> listFestivals = (List<FestivalsContent>)request.getAttribute("listFestivals");%>
                		<%if (listFestivals != null) {%>
                		<%for (FestivalsContent fs : listFestivals) {%>
               	 		{
                			title : '<%=fs.getTitle()%>',
                    		start : '<%=fs.getStart_date()%>',
                    		end : '<%=fs.getEnd_date()%>',
               	 		},
    				<%}
    			}%>
        		],
          	dateClick: function(info) {
             	 // 날짜를 클릭했을 때 출석체크 이벤트를 추가합니다.
             	 calendar.addEvent({ title: '체크', start: info.dateStr });
          	},
          	eventClick: function(info) {
              	// 출석체크 이벤트를 클릭했을 때 도장을 찍었다는 메시지를 표시합니다.
              	alert('체크: ' + info.event.title + ', 날짜: ' + info.event.start);
          	}
       		});
       	
       		calendar.render();
     		});
    </script>
</head>
<body>
<main>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	
	<h1>월별축제달력</h1>
	<div id='calendar'></div>
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</main>
</body>
</html>