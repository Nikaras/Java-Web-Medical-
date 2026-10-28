<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<div class="container">
    <% if (request.getParameter("error").equals("1")) { %>
    <p class="error">You need to be logged in to view this page</p>
    <% } else if (request.getParameter("error").equals("2")) { %>
    <p class="error">This function is only available for patients</p>
    <% } else if (request.getParameter("error").equals("3")) { %>
    <p class="error">This page is only available to admins</p>
    <% } else { %>
        <p class="error">There was an error</p> <br>
    <% } %>
</div>
<div style="max-width: 10%; margin-left: auto; margin-right: auto;">
    <button style="width: 60%; min-width: 100px" type="button" onclick="window.location.href='${pageContext.request.contextPath}'">Main Page</button> <br>
</div>
</body>
</html>
