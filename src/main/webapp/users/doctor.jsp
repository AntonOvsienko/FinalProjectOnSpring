<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
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


        .tabs {
            width: 100%;
            display: flex;
            flex-wrap: wrap;
        / / make sure it wraps
        }

        .tabs label {
            order: 1;
        / / Put the labels first display: block;
            padding: 1rem 2rem;
            margin-right: 0.2rem;
            cursor: pointer;
            background: #90CAF9;
            font-weight: bold;
            transition: background ease 0.2s;
        }

        .tabs .tab {
            order: 99;
        / / Put the tabs last flex-grow: 1;
            width: 100%;
            display: none;
            padding: 1rem;
            background: #fff;
        }

        .tabs input[type="radio"] {
            display: none;
        }

        .tabs input[type="radio"]:checked + label {
            background: #fff;
        }

        .tabs input[type="radio"]:checked + label + .tab {
            display: block;
        }

        @media (max-width: 45em) {
            .tabs .tab,
            .tabs label {
                order: initial;
            }

            .tabs label {
                width: 100%;
                margin-right: 0;
                margin-top: 0.2rem;
            }
        }

        /**
         * Generic Styling
        */
        body {
            background: #eee;
            min-height: 100vh;
            box-sizing: border-box;
            padding-top: 10vh;
            font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
            font-weight: 300;
            line-height: 1.5;
            max-width: 80rem;
            margin: 0 auto;
            font-size: 112%;
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
<div class="tabs">
    <c:forEach items="${doctors}" var="doctor" varStatus="i">
        <fmt:parseNumber var="count" type="number" value="${globalLogin}"/>
        <c:if test="${doctor.getId() == count}">
            <input type="radio" name="tabs" id="tab${i.count}" checked="checked">
            <label for="tab${i.count}">${i.count}</label>
            <div class="tab">
                <iframe src="/controller?command=doctorAppointment&caseRecordId=5" width="100%" height="1000"></iframe>
            </div>
        </c:if>
    </c:forEach>

    <%--    <input type="radio" name="tabs" checked="checked">--%>
    <%--    <label for="tabone">Tab One</label>--%>
    <%--    <div class="tab">--%>
    <%--        <iframe src="/controller?command=doctorAppointment&caseRecordId=5" width="100%" height="1000"></iframe>--%>
    <%--    </div>--%>

    <%--    <input type="radio" name="tabs" id="tabtwo">--%>
    <%--    <label for="tabtwo">Tab Two</label>--%>
    <%--    <div class="tab">--%>
    <%--        <h1>Tab Two Content</h1>--%>
    <%--        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et--%>
    <%--            dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex--%>
    <%--            ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat--%>
    <%--            nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit--%>
    <%--            anim id est laborum.</p>--%>
    <%--    </div>--%>

    <%--    <input type="radio" name="tabs" id="tabthree">--%>
    <%--    <label for="tabthree">Tab Three</label>--%>
    <%--    <div class="tab">--%>
    <%--        <h1>Tab Three Content</h1>--%>
    <%--        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>--%>
    <%--    </div>--%>
</div>


<%--<h1>Hello Doctor</h1>--%>
<%--<h3>--%>
<%--    Login:${globalLogin}<br>--%>
<%--    Name:${name}<br>--%>
<%--    Surname:${surname}<br>--%>
<%--    Passport:${passport}<br>--%>
<%--</h3>--%>
<%--<form id="auth" action="/controller" method="get">--%>
<%--    <input name="address" value="users/updateAccount.jsp" hidden>--%>
<%--    <p><input type="submit" value="Обновить профиль"></p>--%>
<%--</form>--%>
<%--<form action="/controller" method="">--%>

<%--</form>--%>
<%--<form action="/controller" method="post">--%>
<%--    <input name="command" value="doctorAppointment" hidden>--%>
<%--    <p>--%>
<%--    <div class="tab">--%>
<%--        <table>--%>
<%--            <tr>--%>
<%--                <th align="center">id</th>--%>
<%--                <th class="cell">Пациент</th>--%>
<%--                <th class="cell">Диагноз</th>--%>
<%--                <th class="cell">Назначение врача</th>--%>
<%--            </tr>--%>
<%--            <c:forEach items="${doctors}" var="doctor">--%>
<%--                <c:if test="${doctor.getLogin() == globalLogin}">--%>
<%--                    <c:forEach items="${doctor.getCaseRecords()}" var="entry" varStatus="i">--%>
<%--                        <tr>--%>
<%--                            <th align="center">${i.count}</th>--%>
<%--                            <th class="cell">${entry.getPatient().getName()} ${entry.getPatient().getSurname()}</th>--%>
<%--                            <th class="cell">${entry.getInitialDiagnosis()}</th>--%>
<%--                            <th><input type="submit" value="Перейти"></th>--%>
<%--                            <input name="caseRecordId" value="${entry.getId()}" hidden>--%>
<%--                        </tr>--%>
<%--                    </c:forEach>--%>
<%--                </c:if>--%>
<%--            </c:forEach>--%>
<%--        </table>--%>
<%--    </div>--%>
<%--    </p>--%>
<%--</form>--%>
<%--<form id="auth1" action="controller" method="get">--%>
<%--    <input name="command" value="exit" hidden>--%>
<%--    <p><input type="submit" value="Закончить сессию"></p>--%>
<%--</form>--%>
</body>
</html>