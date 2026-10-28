<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add User</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>

  <form action="addUser" method="post">
    <input type="text" name="username" placeholder="Username" required />
    <input type="password" name="password" placeholder="Password" required />
    <input type="text" name="fname" placeholder="First Name" required />
    <input type="text" name="lname" placeholder="Last Name" required />
    <% if (request.getParameter("usertype").equals("doctor")) { %>
    <input type="text" name="speciality" placeholder="Speciality" required />
    <input type="hidden" name="acc_type" value="doctor" />
    <input type="submit" value="Add Doctor" /> <br>
    <% } else {%>
      <input type="text" name="amka" placeholder="AMKA" required />
    <input type="hidden" name="acc_type" value="patient" />
    <input type="submit" value="Add Patient" /> <br>
    <%}%>
  </form>
</body>
</html>
