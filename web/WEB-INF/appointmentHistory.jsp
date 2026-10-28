<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Appointment" %>
<!DOCTYPE html>
<html>
<head>
    <title>Appointment History</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<div class="container" style="max-width: 1000px;">
    <h2>Active Appointments</h2>
    <table>
        <thead>
        <tr>
            <th>Date</th>
            <th>Time</th>
            <th>Status</th>
            <% if (session.getAttribute("UserType").equals("patient")) { %>
<%--            <% if (request.getParameter("UserType").equals("patient")) { %>--%>
            <th>Doctor</th>
            <% } else { %>
            <th>Patient</th>
            <% } %>
        </tr>
        </thead>
        <tbody>
        <%
            ArrayList<Appointment> appointments = (ArrayList<Appointment>) request.getAttribute("Appointments");
            for (Appointment appt : appointments) {
                if (appt.getStatus().equals("pending")) {
        %>
        <tr>
            <td><%= appt.getDate() %></td>
            <td><%= appt.getHour() %></td>
            <td>Pending</td>
            <% if (session.getAttribute("UserType").equals("patient")) { %>
            <td><%="(" + appt.getDoctor().getSpecialty() + ") " +  appt.getDoctor().getFirstName() + " " + appt.getDoctor().getLastName()%></td>
            <td id="hidden-doc" style="display: none"><%= appt.getDoctor().getUsername() %></td>
            <td><button name="cancel-button" style="width: 100%" onclick="changeStatus(this, 'cancelled', false)">Cancel Appointment</button></td>
            <td><button name="complete-button" style="width: 100%" onclick="changeStatus(this, 'completed', false)">Complete Appointment</button></td>
            <% } else {%>
            <td><%= appt.getPatient().getFirstName() + " " + appt.getPatient().getLastName() %></td>
            <td id="hidden-doc" style="display: none"><%= appt.getPatient().getUsername() %></td>
            <td><button name="cancel-button" style="width: 100%" onclick="changeStatus(this, 'cancelled', true)">Cancel Appointment</button></td>
            <td><button name="complete-button" style="width: 100%" onclick="changeStatus(this, 'completed', true)">Complete Appointment</button></td>
            <% } %>
        </tr>
        <% }} %>
        </tbody>
    </table>
</div>
<div class="container" style="max-width: 1000px;">
    <h2>Completed or Canceled Appointments</h2>
    <table>
        <thead>
        <tr>
            <th>Date</th>
            <th>Time</th>
            <th>Status</th>
            <% if (session.getAttribute("UserType").equals("patient")) { %>
            <%--            <% if (request.getParameter("UserType").equals("patient")) { %>--%>
            <th>Doctor</th>
            <% } else { %>
            <th>Patient</th>
            <% } %>
        </tr>
        </thead>
        <tbody>
        <%
            for (Appointment appt : appointments) {
                if (appt.getStatus().equals("completed") || appt.getStatus().equals("cancelled")) {
        %>
        <tr>
            <td><%= appt.getDate() %></td>
            <td><%= appt.getHour() %></td>
            <td><%= appt.getStatus().substring(0, 1).toUpperCase() + appt.getStatus().substring(1) %></td>
            <% if (session.getAttribute("UserType").equals("patient")) { %>
            <td><%="(" + appt.getDoctor().getSpecialty() + ") " +  appt.getDoctor().getFirstName() + " " + appt.getDoctor().getLastName()%></td>
            <% } else {%>
            <td><%= appt.getPatient().getFirstName() + " " + appt.getPatient().getLastName()%></td>
            <td style="display: none"><%= appt.getPatient().getUsername()%></td>
            <% } %>
        </tr>
        <% }} %>
        </tbody>
    </table>
</div>
<div style="max-width: 10%; margin-left: auto; margin-right: auto;">
    <button style="width: 60%; margin: auto; min-width: 100px" type="button" onclick="window.location.href='${pageContext.request.contextPath}'">Main Page</button> <br>
</div>
<script>
    let cancelButtons = document.getElementsByName("cancel-button");
    for (let button of cancelButtons) {
        checkDate(button);
    }

    function checkDate(button) {
        let targetDateSplit = button.closest("tr").cells[0].innerText.split("-");
        let year = parseInt(targetDateSplit[0]);
        let month = parseInt(targetDateSplit[1]) - 1;
        let day = parseInt(targetDateSplit[2]);
        let targetDate = new Date(year, month, day);
        let threeDaysFromNow = new Date(new Date().getTime() + (3 * 24 * 60 * 60 * 1000));

        console.debug("if ", targetDate + " < " + threeDaysFromNow);
        if (targetDate <= threeDaysFromNow) {
            console.debug("date is within 3 days", threeDaysFromNow);
            button.classList.add("disabled");
            button.disabled = true;
        }
    }

    function changeStatus(button, status, doc) {
        let freeUpAvailability = true;
        if (doc) {
            freeUpAvailability = confirm("Do you want to also free up the time slot?");
        }
        const row = button.closest("tr");
        let data = {
            date: row.cells[0].innerText,
            time: row.cells[1].innerText,
            status: status,
            otherUser: row.cells[4].innerText,
            freeUpAvailability: freeUpAvailability
        }
        console.debug("data raw", data);
        console.debug("data json", JSON.stringify(data));
        fetch("${pageContext.request.contextPath}/history", {method: 'POST', body: JSON.stringify(data)})
            .then(res => res.json())
            .then((data) => {window.location.href = data.redirect;}) // refresh after post
    }
</script>
</body>
</html>