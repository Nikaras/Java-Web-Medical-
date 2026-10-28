<%--
  Created by IntelliJ IDEA.
  User: george
  Date: 23/8/25
  Time: 3:54 μ.μ.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Availability</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        #applyDay {
            /*width: 30%;*/
            margin-left: 30px;
        }

        #applyMonth {
            margin-left: 30px;
        }

        button[name="available"] {
            width: 15%;
            color:white;
            background-color: #3eb85f;
        }

        button[name="available"]:hover {
            width: 15%;
            color:white;
            background-color: #21944b;
        }

        button[name="unavailable"] {
            width: 15%;
            color:white;
            background-color: #c23e3e;
        }
        button[name="unavailable"]:hover {
            width: 15%;
            color:white;
            background-color: #942f2f;
        }

    </style>
</head>
<script>


</script>
<body>
<% if ((session.getAttribute("ConnectedUser") == null)) { %>
<div class="container">
    <h2 style="color: red">You need to be logged in</h2>
</div>
<% } else {%>
<div class="container">
    <h2>View/Edit Availability</h2>
    <button type="button" onclick="toggleVisibility('day-picker')">Day</button>
    <button type="button" onclick="toggleVisibility('month-picker')">Month</button>
<%--        <button type="button" onclick="toggleVisibility('year-picker')">Year</button>--%>
    <div id="day-picker" style="display: none">
        <br>
        <label for="day" class="day">Pick a date:</label>
        <input onchange="markAvailability()" type="date" id="day" name="day"> <br><br>
        <button id="d1" type="button" name="unavailable" onclick="toggleAvailability(this.id)">8:00-9:00</button>
        <button id="d2" type="button" name="unavailable" onclick="toggleAvailability(this.id)">9:00-10:00</button>
        <button id="d3" type="button" name="unavailable" onclick="toggleAvailability(this.id)">10:00-11:00</button>
        <button id="d4" type="button" name="unavailable" onclick="toggleAvailability(this.id)">11:00-12:00</button>
        <button id="applyDay" type="button" name="applyDay" onclick="addDay()">Apply Schedule to day</button><br><br>
        <button id="d5" type="button" name="unavailable" onclick="toggleAvailability(this.id)">12:00-13:00</button>
        <button id="d6" type="button" name="unavailable" onclick="toggleAvailability(this.id)">13:00-14:00</button>
        <button id="d7" type="button" name="unavailable" onclick="toggleAvailability(this.id)">14:00-15:00</button>
        <button id="d8" type="button" name="unavailable" onclick="toggleAvailability(this.id)">15:00-16:00</button><br><br>
        <button id="d9" type="button" name="unavailable" onclick="toggleAvailability(this.id)">16:00-17:00</button>
        <button id="d10" type="button" name="unavailable" onclick="toggleAvailability(this.id)">17:00-18:00</button>
        <button id="d11" type="button" name="unavailable" onclick="toggleAvailability(this.id)">18:00-19:00</button>
        <button id="d12" type="button" name="unavailable" onclick="toggleAvailability(this.id)">19:00-20:00</button>

    </div>
    <div id="month-picker" style="display: none">
        <br>
        <label for="month" class="month">Pick a month:</label>
        <input type="month" id="month" name="month"><br><br>
        <button id="m1" type="button" name="unavailable" onclick="toggleAvailability(this.id)">8:00-9:00</button>
        <button id="m2" type="button" name="unavailable" onclick="toggleAvailability(this.id)">9:00-10:00</button>
        <button id="m3" type="button" name="unavailable" onclick="toggleAvailability(this.id)">10:00-11:00</button>
        <button id="m4" type="button" name="unavailable" onclick="toggleAvailability(this.id)">11:00-12:00</button>
        <button id="applyMonth" type="button" name="applyMonth" onclick="applyMonth(document.getElementById('month').value)">Apply Schedule to whole month</button><br><br>
        <button id="m5" type="button" name="unavailable" onclick="toggleAvailability(this.id)">12:00-13:00</button>
        <button id="m6" type="button" name="unavailable" onclick="toggleAvailability(this.id)">13:00-14:00</button>
        <button id="m7" type="button" name="unavailable" onclick="toggleAvailability(this.id)">14:00-15:00</button>
        <button id="m8" type="button" name="unavailable" onclick="toggleAvailability(this.id)">15:00-16:00</button><br><br>
        <button id="m9" type="button" name="unavailable" onclick="toggleAvailability(this.id)">16:00-17:00</button>
        <button id="m10" type="button" name="unavailable" onclick="toggleAvailability(this.id)">17:00-18:00</button>
        <button id="m11" type="button" name="unavailable" onclick="toggleAvailability(this.id)">18:00-19:00</button>
        <button id="m12" type="button" name="unavailable" onclick="toggleAvailability(this.id)">19:00-20:00</button>
        <h3 style="color: #942f2f">Warning! this will apply to the entire month, discarding any other selections</h3>
    </div>

    <form id="formValue" action="availability" method="post">
        <input type="hidden" name="availabilityJson" id="availabilityJson" value="">
    </form>

</div>


<% } %>



<div style="max-width: 35%; margin-left: auto; margin-right: auto;">
<%--    <button style="width: 60%; min-width: 100px" type="button" onclick="window.location.href='${pageContext.request.contextPath}'">Main Page</button> <br>--%>
    <button style="width: 45%; min-width: 100px" type="button" onclick="window.location.href='${pageContext.request.contextPath}'">Cancel</button>
    <button style="width: 45%; min-width: 100px" id="saveButton" onclick="updateAvailability()" type="button">Save Changes</button>
</div>
<script>
    // Object.entries(sessionStorage.getItem('Availability'))
    let localList = new Map(Object.entries(<%= request.getAttribute("Availability") %>))
    console.log(localList);

    // Functions
    {
        function toggleVisibility(id) {
            if (document.getElementById(id).style.display === "none") {
                document.getElementById(id).style.display = "block";
            } else if (document.getElementById(id).style.display === "block") {
                document.getElementById(id).style.display = "none";
            }
            switch (id) {
                case 'day-picker':
                    document.getElementById('month-picker').style.display = "none";
                    // document.getElementById('year-picker').style.display = "none";
                    break;
                case 'month-picker':
                    document.getElementById('day-picker').style.display = "none";
                    // document.getElementById('year-picker').style.display = "none";
                    break;
                // case 'year-picker':
                //     document.getElementById('day-picker').style.display = "none";
                //     document.getElementById('month-picker').style.display = "none";
            }
        }

        function toggleAvailability(id) {
            if (document.getElementById(id).getAttribute('name') === "unavailable") {
                document.getElementById(id).setAttribute('name', "available");
                console.log(id + " available");
            } else if (document.getElementById(id).getAttribute('name') === "available") {
                document.getElementById(id).setAttribute('name', "unavailable");
                console.log(id + " unavailable");
            }
        }

        function addDay() {
            let date = document.getElementById('day').value;
            let hours = [];
            document.getElementsByName('available').forEach(element => {
                if (element.getAttribute('id').startsWith('d')) {
                    hours.push(element.textContent);
                }
            })
            localList.set(date, hours);
            console.log(localList);
        }

        function applyMonth(monthValue) {
            // make schedule
            let hours = [];
            document.getElementsByName('available').forEach(element => {
                if (element.getAttribute('id').startsWith('m')) {
                    hours.push(element.textContent);
                }
            })

            const month = monthValue.split('-')[1] // extract month from month value, which has format yyyy-mm
            let from = new Date();
            let to = new Date();

            if (from.getMonth() !== month - 1) { // if month is different from current one, set start date to 1 (start of the month), else leave it at current date
                from.setDate(1)
            }
            from.setMonth(month - 1);
            to.setMonth(month);
            to.setDate(1)


            // loop for every day
            for (let day = from; day < to; day.setDate(day.getDate() + 1)) {
                let dd = day.getDate();
                let mm = day.getMonth() + 1;
                let yyyy = day.getFullYear();
                if (dd < 10) {
                    dd = '0' + dd;
                }
                if (mm < 10) {
                    mm = '0' + mm;
                }
                let dayFormatted = yyyy + '-' + mm + '-' + dd;
                // your day is here
                // console.log(dayFormatted)
                localList.set(dayFormatted, hours)
            }
            console.log(localList);
        }

        function markAvailability() {
            let tempArray = [];

            console.log(document.getElementsByName('available'))
            document.getElementsByName('available').forEach(element => { // mark all as unavailable
                console.log(element.getAttribute('id'));
                if (element.getAttribute('id').startsWith('d')) {
                    console.log(element.getAttribute('id'));
                    console.log("marked " + element.textContent + " unavailable");
                    // element.setAttribute('name', "unavailable");
                    tempArray.push(element); // adding to a temporary array instead of directly modifying to avoid destructive iteration
                }
            })

            tempArray.forEach(element => {
                element.setAttribute('name', "unavailable");
            })
            let date = document.getElementById('day').value;
            tempArray = [];
            document.getElementsByName('unavailable').forEach(element => { // mark the correct ones as available
                console.log(element.getAttribute('id'));
                if (element.getAttribute('id').startsWith('d')) {
                    console.log("localList.has(date): " + localList.has(date))
                    console.log("localList.get(date).includes(element.textContent)): " + localList.get(date).includes(element.textContent))
                    console.log(localList.get(date))
                    console.log(element.textContent)
                    if (localList.has(date) && localList.get(date).includes(element.textContent)) {
                        // element.setAttribute('name', "available");
                        tempArray.push(element);
                    }
                }
            })
            tempArray.forEach(element => {
                element.setAttribute('name', "available");
            })

        }

        function updateAvailability() {

            let jsonString = JSON.stringify(Object.fromEntries(localList));
            console.log(jsonString);
            document.getElementById('availabilityJson').value = jsonString;
            document.getElementById('formValue').submit();
        }
    }

    // Date picker Limits
    {
        let today = new Date();
        let dd = today.getDate();
        let mm = today.getMonth() + 1; //january is 0
        let MM = today.getMonth() + 4; // set max 3 months from now
        let yyyy = today.getFullYear();

        if (dd < 10) {
            dd = '0' + dd;
        }

        if (mm < 10) {
            mm = '0' + mm;
        }

        if (MM < 10) {
            MM = '0' + MM;
        }

        let minDay = yyyy + '-' + mm + '-' + dd;
        let maxDay = yyyy + '-' + MM + '-' + dd;
        document.getElementById("day").setAttribute("min", minDay);
        document.getElementById("day").setAttribute("max", maxDay);
        document.getElementById("day").value = minDay;
        markAvailability()

        let minMonth = yyyy + '-' + mm;
        let maxMonth = yyyy + '-' + MM;
        document.getElementById("month").setAttribute("min", minMonth);
        document.getElementById("month").setAttribute("max", maxMonth);
        document.getElementById("month").value = minMonth;
    }
</script>
</body>
</html>
