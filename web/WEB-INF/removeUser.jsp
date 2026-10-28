<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add User</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>

<form action="removeUser" method="post">
    <input type="text" name="username" placeholder="Username" required />
    <input type="text" name="fname" placeholder="First Name" required />
    <input type="text" name="lname" placeholder="Last Name" required />
    <input type="submit" value="Remove Doctor" /> <br>
</form>
</body>
</html>
