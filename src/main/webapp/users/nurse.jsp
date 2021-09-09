<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <style>

        table {
            font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
            font-size: 14px;
            background: white;
            max-width: 70%;
            width: 90%;
            border-collapse: collapse;
            text-align: left;
        }

        th.table1 {
            font-weight: normal;
            color: #039;
            border-bottom: 2px solid #6678b1;
            padding: 10px 8px;
        }

        td.table1 {
            border-bottom: 1px solid #ccc;
            color: #669;
            padding: 9px 8px;
            transition: .3s linear;
        }

        tr:hover td {
            color: #6699ff;
        }

        table.table2 {
            border: 1px solid #6cf;
        }

        th.table2 {
            font-weight: normal;
            font-size: 13px;
            color: #039;
            text-transform: uppercase;
            border-right: 1px solid #0865c2;
            border-top: 1px solid #0865c2;
            border-left: 1px solid #0865c2;
            border-bottom: 1px solid white;
            padding: 20px;
        }

        td.table2 {
            color: #669;
            border-right: 1px dashed #6cf;
            padding: 10px 20px;
        }

    </style>
</head>
<body>
<h1>Hello Nurse</h1>
<h3>
    Login:${login}<br>
    Name:${name}<br>
    Surname:${surname}<br>
    Passport:${passport}<br>
</h3>
<c:forEach items="${appointmentList}" var="entry">
    <input type="hidden" name="id" value="${entry.getId()}"/>
    <table align="center">
        <caption>${entry.getPatient().getName()}
                ${entry.getPatient().getSurname()}
                (${entry.getInitialDiagnosis()})</caption>
        <tr class="table1">
            <th class="table1" align="center" width="5%">id</th>
            <th class="table1" width="20%">Назначение</th>
            <th class="table1" width="50%">Подробности</th>
            <th class="table1">Выполнено</th>
        </tr>
        <form action="/controller" method="post" class="form">
            <c:forEach items="${entry.getDoctorAppointmentList()}" var="appointment" varStatus="i">
            <c:if test="${appointment == null}">
            <tr class="table1">
                <th class="table1" colspan="4" class="table1" align="center">Нет назначений врача</th>
            </tr>
            </c:if>
            <c:if test="${appointment != null}">
            <c:if test="${appointment.getComplete() != 'true'}">
            <tr class="table1">
                <td class="table1" align="center">${i.count}</td>
                <td class="table1">${appointment.getType()}</td>
                <td class="table1">${appointment.getDescription()}</td>
                <td class="table1">
                    <input type="checkbox"
                           name="appointment"
                           value="${appointment.getId()}">
                </td>
            </tr>
            </c:if>
            <c:if test="${appointment.getComplete() == 'true'}">
            <div class="toggle-button">
                <tr id="auth2" class="table1">
                    <td class="table1" align="center">${i.count}</td>
                    <td class="table1"><s>${appointment.getType()}</s></td>
                    <td class="table1"><s>${appointment.getDescription()}</s></td>
                    <td class="table1">
                            ${appointment.getNameStaffComplete()}
                    </td>
                </tr>
            </div>
            </c:if>
            </c:if>
            </c:forEach>
    </table>
    <p align="center">
        <button type="submit" name="command" value="confirmNurseAppointment"
                onclick='return confirm("Подтвердить выполнение")'>
            Выполнить
        </button>
    </p>
    </form>

</c:forEach>


</body>
</html>