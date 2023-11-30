<%@page import="java.util.Date"%>
<%@ page import="com.oracle.s202350104.model.FestivalsContent"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FestivalCalendar</title>
<style type="text/css">
	
	h1 {
	font-size: 25px;
	font: bold;
	max-width: 900px;
	margin: 0 auto;
	}
	
	.fc .fc-toolbar-title {
	font-size: 50px;
	color: #FF4379;
	
	}
	.fc-event-title-container{
	background-color: #EEFFC2;
	color: black;
	}
	.fc-day-sun a { 
 	 color: red;
  	text-decoration: none;
	}

	.fc-day-sat a {
  	color: blue;
  	text-decoration: none;
	}
	#calendar {
	max-width: 900px;
	margin: 0 auto;

</style>
 <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.9/index.global.min.js'></script>
   <script>
   		
   document.addEventListener('DOMContentLoaded', function() {
       var calendarEl = document.getElementById('calendar');
       var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        navLinks: true,
        selectable: true, // 달력 일자 드래그 설정가능
        dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
        locale: 'ko', // 한국어 설정
        dayCellContent: function(info) { //일 삭제
        	var number = document.createElement("a");
        	number.classList.add("fc-daygrid-day-number");
        	number.innerHTML = info.dayNumberText.replace("일","");
        	if(info.view.type ==="dayGridMonth") {
        		return {
        			html: number.outerHTML
        		};
        	}
        	return {
        		domNodes: []
        	};
        },
        events: [	
		        	<%List<FestivalsContent> listFestivals = (List<FestivalsContent>)request.getAttribute("listFestivals");
		        		if (listFestivals != null) {
		        		for (FestivalsContent fs : listFestivals) {%>
	               	 		{ 
	                			title : "<%=fs.getTitle()%>",
	                    		start : "<%=fs.getStartdateStr()%>",
	                    		end   : "<%=fs.getEnddateStr()%>",
	                    		color : "#EEFFC2",
	                            textColor : "#000000",
	                            url: "${pageContext.request.contextPath}/festival/detail?contentId="+<%=fs.getContent_id()%> // 축제명 클릭시 상세페이지 이동
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
              	/* alert('체크: ' + info.event.title + ', 날짜: ' + info.event.start); */
          		alert(info.event.title + ' 상세페이지로 이동 합니다.'); 
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