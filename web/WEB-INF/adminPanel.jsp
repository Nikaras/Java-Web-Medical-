<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Admin Panel</title>--%>
<%--</head>--%>
<%--<body>--%>
<%--<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/addUser.jsp?usertype=patient'">Add Patient</button>--%>
<%--<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/addUser.jsp?usertype=doctor'">Add Doctor</button>--%>
<%--</body>--%>
<%--</html>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<div class="container">
    <h2>Admin Panel</h2>
    <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/addUser?usertype=patient'">Add Patient</button>
    <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/addUser?usertype=doctor'">Add Doctor</button>
    <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/removeUser'">Remove Doctor</button>
</div>
<div style="max-width: 10%; margin-left: auto; margin-right: auto;">
    <button style="width: 60%; min-width: 100px" type="button" onclick="window.location.href='${pageContext.request.contextPath}'">Main Page</button> <br>
</div>
</body>
</html>


