<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <style>
        table {
            border: 1px solid grey;
            width: 600px;
            text-align: left;
            border-collapse: collapse;
        }

        th.cell {
            padding-left: 8px;
            padding-top: 5px;
            padding-bottom: 5px;
        }

        th {
            border: 1px solid grey;
        }

        td {
            border: 1px solid grey;
        }
    </style>
    <script>
        function showForm() {
            if (document.getElementById("auth").hidden == false) {
                document.getElementById("auth").hidden = true;
            } else {
                document.getElementById("auth").hidden = false;
            }
        }
    </script>
</head>
<body>
<h1>Hello Doctor</h1>
<h3>
    Login:${globalLogin}<br>
    Name:${name}<br>
    Surname:${surname}<br>
    Passport:${passport}<br>
</h3>
<form id="auth" action="/controller" method="get">
    <input name="address" value="users/updateAccount.jsp" hidden>
    <p><input type="submit" value="Обновить профиль"></p>
</form>
<form action="/controller" method="">

</form>
<form action="/controller" method="post">
    <input name="command" value="doctorAppointment" hidden>
    <p>
    <div class="tab">
        <table>
            <tr>
                <th align="center">id</th>
                <th class="cell">Пациент</th>
                <th class="cell">Диагноз</th>
                <th class="cell">Назначение врача</th>
            </tr>
            <c:forEach items="${doctors}" var="doctor">
                <c:if test="${doctor.getLogin() == globalLogin}">
                    <c:forEach items="${doctor.getCaseRecords()}" var="entry" varStatus="i">
                        <tr>
                            <th align="center">${i.count}</th>
                            <th class="cell">${entry.getPatient().getName()} ${entry.getPatient().getSurname()}</th>
                            <th class="cell">${entry.getInitialDiagnosis()}</th>
                            <th><input type="submit" value="Перейти"></th>
                            <input name="caseRecordId" value="${entry.getId()}" hidden>
                        </tr>
                    </c:forEach>
                </c:if>
            </c:forEach>
        </table>
    </div>
    </p>
</form>
<form id="auth1" action="controller" method="get">
    <input name="command" value="exit" hidden>
    <p><input type="submit" value="Закончить сессию"></p>
</form>
</body>
</html>