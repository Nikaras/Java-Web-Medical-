<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Details</title>
    <style>
        body {
            background-color: #f1f8e9;
            font-family: 'Segoe UI', sans-serif;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }
        h2 {
            color: #333;
            text-align: center;
        }
        table {
            width: 100%;
            margin-top: 20px;
        }
        td {
            padding: 10px;
            font-size: 16px;
        }
        td.label {
            font-weight: bold;
            width: 40%;
        }
        button {
            padding: 12px;
            background-color: #5c6bc0;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="container">
    <% if ((session.getAttribute("ConnectedUser") != null)) { %>
    <h2>User Information</h2>
    <table>
        <tr><td class="label">Username:</td><td><%= request.getAttribute("username") %></td></tr>
        <tr><td class="label">Name:</td><td><%= request.getAttribute("name") %></td></tr>
        <tr><td class="label">Surname:</td><td><%= request.getAttribute("surname") %></td></tr>
        <% if (session.getAttribute("UserType").toString().equals("doctor")) { %>
        <tr><td class="label">Speciality:</td><td><%= request.getAttribute("speciality") %></td></tr>
        <% } else if (session.getAttribute("UserType").toString().equals("patient")){ %>
        <tr><td class="label">AMKA:</td><td><%= request.getAttribute("amka") %></td></tr>
        <% } %>
    </table>
    <% } else { %>
    <h2 style="color: red">You need to be logged in</h2>
<% } %>
</div>
<div style="max-width: 10%; margin-left: auto; margin-right: auto;">
    <button style="width: 60%; min-width: 100px" type="button" onclick="window.location.href='${pageContext.request.contextPath}'">Main Page</button> <br>
</div>
</body>
</html>