<%@ page import="com.ua.entity.Doctor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <script>
        function openCity(evt, login) {
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(login).style.display = "block";
            evt.currentTarget.className += " active";
        }

        // Get the element with id="defaultOpen" and click on it
        document.getElementById("defaultOpen").click();
    </script>
    <style>
        .MyMarginLeft {
            margin-left: 30px;
        }

        #left {
            position: absolute;
            left: 20px;
            top: 0;
            width: 50%;
        }

        #right {
            position: absolute;
            right: 0;
            top: 0;
            width: 50%;
        }

        * {
            box-sizing: border-box;
        }

        body {
            font-family: "Lato", sans-serif;
        }

        /* Style the tab */
        .tab {
            float: left;
        }

        .button {
            clear: both;
        }

        /* Style the buttons inside the tab */
        .tab option {

            padding: 2px 16px;
            line-height: 1;
            text-align: left;
            cursor: pointer;
        }

        /* Style the tab content */
        .tabcontent {
            font-size: 15px;
            line-height: 10px;
            padding: 0px 10px;
            size: 10px;
            float: left;
        }

        .tabcontent p.login {
            opacity: 50%;
        }

    </style>
</head>
<body>
<div id="left">
    <h3>Врачи</h3>
    <form action="/controller" method="post">
        <input name="command" value="deleteDoctor" hidden>
        <c:if test="${check == 'on'}">
            <div class="tab">
                <p><select name="select" size="15" multiple>
                    <optgroup label="Педиатр">
                        <c:forEach items="${doctors}" var="entry">
                            <c:if test="${entry.getDepartment() == 'Педиатр' }">
                                <option value="${entry.getId()}" class="tablinks"
                                        onclick="openCity(event, '${entry.getLogin()}')">${entry.getName()}
                                        ${entry.getSurname()}</option>
                            </c:if>
                        </c:forEach>
                    </optgroup>
                    <optgroup label="Хирург">
                        <c:forEach items="${doctors}" var="entry">
                            <c:if test="${entry.getDepartment() == 'Хирург' }">
                                <option value="${entry.getId()}" class="tablinks"
                                        onclick="openCity(event, '${entry.getLogin()}')">${entry.getName()}
                                        ${entry.getSurname()}</option>
                            </c:if>
                        </c:forEach>
                    </optgroup>
                    <optgroup label="Терапевт">
                        <c:forEach items="${doctors}" var="entry">
                            <c:if test="${entry.getDepartment() == 'Терапевт' }">
                                <option value="${entry.getId()}" class="tablinks"
                                        onclick="openCity(event, '${entry.getLogin()}')">${entry.getName()}
                                        ${entry.getSurname()}</option>
                            </c:if>
                        </c:forEach>
                    </optgroup>
                    <optgroup label="Травматолог">
                        <c:forEach items="${doctors}" var="entry">
                            <c:if test="${entry.getDepartment() == 'Травматолог' }">
                                <option value="${entry.getId()}" class="tablinks"
                                        onclick="openCity(event, '${entry.getLogin()}')">${entry.getName()}
                                        ${entry.getSurname()}</option>
                            </c:if>
                        </c:forEach>
                    </optgroup>
                </select></p>
            </div>
        </c:if>
        <c:if test="${check != 'on'}">
            <div class="tab">
                <p><select name="select" size="15" multiple>
                    <c:forEach items="${doctors}" var="entry">
                        <option value="${entry.getId()}" class="tablinks"
                                onclick="openCity(event, '${entry.getLogin()}')">${entry.getName()}
                                ${entry.getSurname()}</option>
                    </c:forEach>
                </select></p>
            </div>
        </c:if>
        <c:forEach items="${doctors}" var="entry">
            <div id="${entry.getLogin()}" class="tabcontent" hidden>
                <output>
                    <p class="login">Login : ${entry.getLogin()}</p>
                    <p>Passport : ${entry.getPassport()}</p>
                    <p>Name : ${entry.getName()}</p>
                    <p>Surname : ${entry.getSurname()}</p>
                    <p>Phone : ${entry.getTelephone()}</p>
                    <p>Department : ${entry.getDepartment()}</p>
                    <p>Patient case :</p>
                    <c:forEach items="${entry.getCaseRecords()}" var="card">
                        <p class="MyMarginLeft">${card.getPatient().getName()} ${card.getPatient().getSurname()}(${card.getInitialDiagnosis()})</p>
                    </c:forEach>
                </output>
            </div>
        </c:forEach>
        <div class="button">
            <input type="submit" value="Удалить сотрудника">
        </div>
    </form>
    <div class="button">
        <p align="left">
        <form id="createLogin" action="/controller" method="get">
            <input name="command" value="checkNewLogin" hidden>
            <input type="submit" value="Добавить сотрудника">
        </form>
        <form id="sort" action="/controller" method="get">
            <c:if test="${check!='on'}">
                <label><input type="checkbox" name="check" value="on">Разбить по категориям</label><br>
            </c:if>
            <c:if test="${check=='on'}">
                <label><input type="checkbox" name="check" value="on" checked>Разбить по категориям</label><br>
            </c:if>
            <c:if test="${sort=='sortByName'|| sort==null}">
                <label><input type="radio" name="sort" value="sortByName" checked>Сортировать по имени</label><br>
                <label><input type="radio" name="sort" value="sortByCount">Сортировать по кол-ву пациентов</label><br>
            </c:if>
            <c:if test="${sort=='sortByCount'}">
                <label><input type="radio" name="sort" value="sortByName">Сортировать по имени</label><br>
                <label><input type="radio" name="sort" value="sortByCount" checked>Сортировать по кол-ву
                    пациентов</label><br>
            </c:if>
            <input type="submit" value="Сортировка">
            <input name="command" value="sortDoctorList" hidden>
        </form>
        </p>
    </div>
    <p align="left">
    <form id="auth" action="/controller" method="get">
        <input name="command" value="redirect" hidden>
        <input name="address" value="users/admin.jsp" hidden>
        <input type="submit" value="Назад">
    </form>
    </p>
</div>

<div id="right">
    <h3>Пациенты</h3>
    <div class="tab">
        <p><select size="15" multiple>
            <c:forEach items="${patients}" var="entry">
                <option class="tablinks"
                        onclick="openCity(event, '${entry.getId()}')">${entry.getName()}
                        ${entry.getSurname()}</option>
            </c:forEach>
        </select></p>
    </div>
    <c:forEach items="${patients}" var="entry">
        <div id="${entry.getId()}" class="tabcontent" hidden>
            <p>Passport : ${entry.getPassport()}</p>
            <p>Birthday : ${entry.getDayBorn()}-${entry.getMonthBorn()}-${entry.getYearBorn()}(${entry.getYears()})</p>
            <p>Name : ${entry.getName()}</p>
            <p>Surname : ${entry.getSurname()}</p>
            <p>Phone : ${entry.getTelephone()}</p>
            <c:forEach items="${entry.getCaseRecords()}" var="card">
                <p class="MyMarginLeft">Диагноз:(${card.getInitialDiagnosis()}) Лечащий врач:
                    <c:if test="${card.getDoctor().getName() != null}">
                        ${card.getDoctor().getName()} ${card.getDoctor().getSurname()}
                    </c:if>
                    <c:if test="${card.getDoctor().getName() == null}">
                        Отсутствует
                    </c:if>
                </p>
            </c:forEach>
        </div>
    </c:forEach>
    <form class="button" action="/controller" method="get">
        <input name="command" value="addNewPatient" hidden>
        <p align="left"><input type="submit" value="Добавить пациентов"></p>
    </form>
    <div class="button">
        <p align="left">
        <form>
            <input name="command" value="sortPatientList" hidden>
            <c:if test="${sort2=='sortByName'|| sort2==null}">
                <label><input type="radio" name="sort2" value="sortByName" checked>Сортировать по имени</label><br>
                <label><input type="radio" name="sort2" value="sortByBirthday">Сортировать по возрасту</label><br>
            </c:if>
            <c:if test="${sort2=='sortByBirthday'}">
                <label><input type="radio" name="sort2" value="sortByName">Сортировать по имени</label><br>
                <label><input type="radio" name="sort2" value="sortByBirthday" checked>Сортировать по
                    возрасту</label><br>
            </c:if>
            <input type="submit" value="Сортировка">
        </form>
        <form class="button" action="/controller" method="post">
            <p>Назначить врача пациенту</p>
            <input name="command" value="doctorToPatient" hidden>
            <p><select name="selectDoctor">
                <c:forEach items="${doctors}" var="entry">
                    <option value="${entry.getId()}">${entry.getName()}
                            ${entry.getSurname()} - ${entry.getDepartment()}</option>
                </c:forEach>
            </select>
                -->
                <select name="selectPatient">
                    <c:forEach items="${patients}" var="entry">
                        <c:forEach items="${entry.getCaseRecords()}" var="diagnose">
                            <c:if test="${diagnose.getDoctor().getName()==null}">
                                <option value="${diagnose.getId()}">${entry.getName()}
                                        ${entry.getSurname()} - ${diagnose.getInitialDiagnosis()}</option>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                </select></p>
            <input type="submit" value="Назначить">
        </form>
    </div>
</div>
<form action="/controller" method="get">
    <input name="command" value="exit" hidden>
    <p align="center"><input type="submit" value="Закончить сессию"></p>
</form>
</body>
</html>