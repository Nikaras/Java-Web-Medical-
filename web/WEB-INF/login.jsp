<%@ page contentType="text/html;charset=UTF-8" language="java"
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        br {
            display: block;
            content: "";
            margin-top: 5px;
        }
        body {
            background: linear-gradient(to right, #8caaee, #85c1dc);
            font-family: 'Segoe UI', sans-serif;
        }
    </style>
</head>
<body>
<div class="login-box" id="login-box">
    <h2 id="h2">Patient Login</h2>
    <form action="login" method="post">
        <select name="acc_type" id="acc_type" onchange="colorChange()">
            <option value="patient" selected="selected">Patient</option>
            <option value="doctor">Doctor</option>
            <option value="admin">Admin</option>
        </select>
        <input type="text" name="username" placeholder="Username" required />
        <input type="password" name="password" placeholder="Password" required />
        <input type="submit" value="Login" /> <br> <br>
        <button style="width: 100%" type="button" onclick="window.location.href='${pageContext.request.contextPath}'">Main Page</button>
        <% if (request.getParameter("error") != null) { %>
            <p class="error">Invalid credentials, please try again.</p>
        <% } %>
    </form>
</div>

<script>
    function colorChange() {
        var x = document.getElementById("acc_type");
        if (x.value === "patient") {
            document.body.style.background = "linear-gradient(to right, #8caaee, #85c1dc)";
            document.getElementById("h2").textContent = "Patient Login";
            document.getElementById("h2").style.color = "#2952a3"
            document.getElementById("login-box").style.borderColor = "#2952a3";
        } else if (x.value === "doctor") {
            document.body.style.background = "linear-gradient(to right, #a6d189, #81c8be)";
            document.getElementById("h2").textContent = "Doctor Login";
            document.getElementById("h2").style.color = "#33691e"
            document.getElementById("login-box").style.borderColor = "#33691e";
        } else if (x.value === "admin") {
            document.body.style.background = "linear-gradient(to right, #e64553, #e78284)";
            document.getElementById("h2").textContent = "Admin Login";
            document.getElementById("h2").style.color = "#990000"
            document.getElementById("login-box").style.borderColor = "#990000";
        }
    }
</script>
</body>
</html>