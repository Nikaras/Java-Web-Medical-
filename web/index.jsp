<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Main Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<div class="container">
    <h2>Main Menu</h2>

    <% if (session.getAttribute("ConnectedUser") == null) { %>
    <button id="login" type="button" onclick="window.location.href='${pageContext.request.contextPath}/login'">Login</button>
    <% }  else {%>
    <button id="logout" type="button" onclick="window.location.href='${pageContext.request.contextPath}/logout'">Logout</button>
    <% if (session.getAttribute("UserType").toString().equals("admin")) {%>
    <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/admin'">Admin Panel</button>
    <% } else { %>
    <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/history'">Appointment History</button>
    <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/user'">User Details</button> <br> <br>
    <%  } if (session.getAttribute("UserType").toString().equals("doctor")){%>
    <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/availability'">Availability</button>
    <% } else if (session.getAttribute("UserType").toString().equals("patient")) {%>
    <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/appointment'">Make Appointment</button>
<% }} %>
</div>
</body>
</html>
