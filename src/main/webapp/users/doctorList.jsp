<%@ page import="com.ua.entity.Doctor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <script>
        document.getElementById("defaultOpen").click();

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

        function openCity2(evt, cityName) {
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent2");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks2");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(cityName).style.display = "block";
            evt.currentTarget.className += " active";
        }
    </script>
    <style>
        @import url(/users/css/highBanner.css);
        @import url(/users/css/doctorList_center.css);

        .vertical-menu {
            width: 200px;
            height: 150px;
            overflow-y: auto;
        }

        .vertical-menu option {
            background-color: #eee;
            color: black;
            display: block;
            padding: 12px;
            text-decoration: none;
        }

        .vertical-menu option:hover {
            background-color: #ccc;
        }

        .vertical-menu option.active {
            background-color: #4CAF50;
            color: white;
        }
    </style>
</head>
<body>
<ul id="nav">
    <li class="right"><p class="tablinks2" onclick="openCity2(event, 'Staff')" id="defaultOpen">Персонал</p></li>
    <li class="right"><p class="tablinks2" onclick="openCity2(event, 'Tokyo')">Медсёстры</p></li>
    <li class="right"><p class="tablinks2" onclick="openCity2(event, 'Paris')">Пациенты</p></li>

    <li class="left"><p><a href="/controller?command=exit">Выход</a></p></li>
    <li class="left"><p>Локаль</p></li>
    <li class="left"><p>Login:${globalLogin}</p></li>
    <li class="left"><p><a href="/controller?command=viewStaff">Обновить</a></p></li>
</ul>

<div id="Staff" class="tabcontent2">
    <form action="/controller" method="post">
        <c:if test="${check == 'on'}">
            <div class="tab">
                <p><select name="select" size="15" multiple>
                    <c:forEach items="${departments}" var="department">
                        <optgroup label="${department.description}">
                            <c:forEach items="${doctors}" var="entry">
                                <c:if test="${entry.getDepartment() == department.description }">
                                    <option value="${entry.getId()}" class="tablinks"
                                            onclick="openCity(event, '${entry.getLogin()}')">${entry.getName()}
                                            ${entry.getSurname()}</option>
                                </c:if>
                            </c:forEach>
                        </optgroup>
                    </c:forEach>
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
            <table>
                <tr>
                    <td>
                        <button type="submit" name="command" value="deleteDoctor" width="100%">Удалить сотрудника
                        </button>
                    </td>
                    <td>
                        <button type="submit" name="command" value="redirect" width="100%">Добавить сотрудника
                        </button>
                    </td>
                </tr>
            </table>
        </div>
        <input name="address" value="users/newLogin.jsp" hidden>
    </form>
    <div class="button">
        <p align="left">
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
        <form action="/controller" method="get">
            <input name="command" value="exit" hidden>
    <p align="left"><input type="submit" value="Закончить сессию"></p>
    </form>
    </p>

</div>

<div id="Tokyo" class="tabcontent2">
    <div class="tab">
        <p><select size="15" multiple>
            <c:forEach items="${nurses}" var="entry">
                <option class="tablinks"
                        onclick="openCity(event, '${entry.getId()}')">${entry.getName()}
                        ${entry.getSurname()}</option>
            </c:forEach>
        </select></p>
    </div>
    <c:forEach items="${nurses}" var="entry">
        <div id="${entry.getId()}" class="tabcontent" hidden>
            <p class="login">Login : ${entry.getLogin()}</p>
            <p>Passport : ${entry.getPassport()}</p>
            <p>Name : ${entry.getName()}</p>
            <p>Surname : ${entry.getSurname()}</p>
            <p>Phone : ${entry.getTelephone()}</p>
        </div>
    </c:forEach>
</div>

<div id="Paris" class="tabcontent2">
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

<script>

    // Get the element with id="defaultOpen" and click on it
    document.getElementById("defaultOpen").click();
</script>
</body>
</html>