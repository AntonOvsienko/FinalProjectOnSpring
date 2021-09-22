<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<html>
<head>
    <style>
        @import url(/users/css/highBanner.css);
        @import url(/users/css/table_case_record.css);
        body {
            font-family: 'Open Sans', Arial, sans-serif;
        }
    </style>
</head>
<body>
<ul id="nav">
    <li class="left"><p><a href="/controller?command=exit">Выход</a></p></li>
    <li class="left"><p>Локаль</p></li>
    <li class="left"><p>Login:${globalLogin}</p></li>
    <li class="left"><p><a href="/controller?command=viewStaff">Назад</a></p></li>
</ul>
<table align="center">
    <tr class="table1">
        <th class="table1" width="5%">id</th>
        <th class="table1" width="15%">Тип</th>
        <th class="table1" width="55%">Подробно</th>
        <th class="table1" width="25%">Выполнил</th>
    </tr>
    <c:forEach items="${doctorAppointments}" var="appointment" varStatus="i">
                <tr class="table1">
                    <td class="table1">${i.count}</td>
                    <td class="table1">${appointment.getType()}</td>
                    <td class="table1">${appointment.getDescription()}</td>
                    <td class="table1">${appointment.getNameStaffComplete()}</td>
                </tr>
    </c:forEach>
</table>

</body>
</html>