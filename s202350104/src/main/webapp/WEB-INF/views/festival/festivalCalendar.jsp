<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FestivalCalendar</title>
 <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.9/index.global.min.js'></script>
   <script>
   document.addEventListener('DOMContentLoaded', function() {
       var calendarEl = document.getElementById('calendar');
       var calendar = new FullCalendar.Calendar(calendarEl, {
         initialView: 'dayGridMonth',
          locale: 'ko',
          events: [
        	    { title: '체크', start: '2023-11-01' },
        	    { title: '체크', start: '2023-11-02' },
        	    { title: '체크', start: '2023-11-03', end: '2023-11-06' }, // 3일 이상 지속되는 이벤트
        	    { title: '체크', start: '2023-11-07' },
        	    { title: '체크', start: '2023-11-08', end: '2023-11-11' }, // 3일 이상 지속되는 이벤트
        	    { title: '체크', start: '2023-11-12' }
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
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	
	<h1>Festival Calendar</h1>
	<div id='calendar'></div>
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>