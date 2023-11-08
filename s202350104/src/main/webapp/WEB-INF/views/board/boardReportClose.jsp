<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function showMessageAndClose() {
    var message = "<%= request.getAttribute("message") %>";
    if (message) {
        alert(message);
    }
    window.close();
}
</script>

</head>
<body onload="showMessageAndClose()">

</body>
</html>