<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .container {
            text-align: center;
        }
        h1 {
            color: #1976d2;
        }
        p {
            color: #555;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Welcome, <%= ((User)session.getAttribute("ConnectedUser")).getFirstName() %>!</h1>
    <p>You have successfully logged in to the Medical Appointment System. <br>
    </p>
</div>
<div style="max-width: 10%; margin-left: auto; margin-right: auto;">
    <button style="width: 60%; margin: auto; min-width: 100px" type="button" onclick="window.location.href='${pageContext.request.contextPath}'">Main Page</button> <br>
</div>
</body>
</html>
 