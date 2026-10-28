<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Doctor" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="general.General" %>
<%@ page import="java.util.Arrays" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<div class="container">
    <form method="POST" action="appointment">
        <label for="doc_username">Select a Doctor:</label><br>
        <select style="width: 49%" name="doc_username" id="doc_username">
            <option value="" disabled selected>Select Doctor</option>
            <%
                ArrayList<Doctor> doctors;
                if (request.getAttribute("Doctors") != null) {
                    doctors = (ArrayList<Doctor>) request.getAttribute("Doctors");
                    for ( Doctor doc : doctors) {
            %>
            <option value="<%= doc.getUsername() %>"><%="(" + doc.getSpecialty() + ") " + doc.getFirstName() + " " + doc.getLastName()%></option>
            <%}}%>
        </select>
        <input style="text-anchor: end; width: 49%" type="submit" value="Search Availability">
    </form>
</div>
<div style="text-align: center;" class="container" id="result">
    <% if (request.getAttribute("Availability") != null) {
            String availabilityJson = request.getAttribute("Availability").toString();
            HashMap<String, ArrayList<String>> availabilityMap = General.jsonToMap(availabilityJson);%>
        <form  method="post" action="makeAppointment" id="appointment-form">
            <input type="hidden" value="" id="selected_doctor" name="selected_doctor">
            <label for="date">Select Date:</label>
            <select style="width: 35%" onchange="changeTimeValues()" name="date" id="date">
                <option value="" disabled selected>Select Date</option>
                <%
                    Object[] keys = availabilityMap.keySet().toArray();
                    Arrays.sort(keys);

                    for (Object key : keys) {%>
                    <option value="<%= key.toString() %>"><%= key.toString() %></option>
                    <%}
                %>
            </select>
            <label style="padding-left: 5%" for="time">Select Time:</label>
            <select style="width: 35%" name="time" id="time">
                <option value="" disabled selected>Select Time</option>
            </select> <br> <br>
            <button style="max-width: 50%" onclick="makeAppointment()" type="button" id="appointment-submit">Make Appointment</button>
        </form>
    <%} else {%>
    No selection made.
    <%}%>
</div>
<div style="max-width: 10%; margin-left: auto; margin-right: auto;">
    <button style="width: 60%; min-width: 100px" type="button" onclick="window.location.href='${pageContext.request.contextPath}'">Main Page</button> <br>
</div>
<script>
    <%if (request.getAttribute("doc_username") != null) {// set the value of the field to the correct username after POST%>
        document.getElementById("doc_username").value = "<%= request.getAttribute("doc_username")%>";

    <%}%>

    function removeOptions(selectElement) {
        var i, L = selectElement.options.length - 1;
        for(i = L; i >= 0; i--) {
            selectElement.remove(i);
        }
    }

    function changeTimeValues() {
        let localList = new Map(Object.entries(<%= request.getAttribute("Availability") %>))
        let date = document.getElementById("date").value;
        let timeSelect = document.getElementById("time")
        removeOptions(timeSelect)
        timeSelect.options[timeSelect.options.length] = new Option("Select Time", "default")
        console.log(date);
        console.log(localList.get(date));
        localList.get(date).forEach(item => {
            timeSelect.options[timeSelect.options.length] = new Option(item, item)
        })

    }

    function makeAppointment() {
        console.log("submitting form");
        document.getElementById("selected_doctor").value = document.getElementById("doc_username").value;
        console.log(document.getElementById("selected_doctor"));
        console.log(document.getElementById("date"))
        console.log(document.getElementById("time"))
        document.getElementById("appointment-form").submit();
    }
</script>
</body>
</html>
