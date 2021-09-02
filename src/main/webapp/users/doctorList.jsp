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
        #left {
            position: absolute;
            left: 0;
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
            padding: 0px 10px;
            size: 20px;
            float: left;
        }

        .tabcontent p.login {
            opacity: 50%;
        }

    </style>
</head>
<body>
<div id="left">
    <c:if test="${check == 'on'}">
        <div class="tab">
            <p><select size="15" multiple>
                <optgroup label="Pediatric">
                    <c:forEach items="${doctors}" var="entry">
                        <c:if test="${entry.getDepartment() == 'Pediatric' }">
                            <option class="tablinks"
                                    onclick="openCity(event, '${entry.getLogin()}')">${entry.getName()}
                                    ${entry.getSurname()}</option>
                        </c:if>
                    </c:forEach>
                </optgroup>
                <optgroup label="Surgeon">
                    <c:forEach items="${doctors}" var="entry">
                        <c:if test="${entry.getDepartment() == 'Surgeon' }">
                            <option class="tablinks"
                                    onclick="openCity(event, '${entry.getLogin()}')">${entry.getName()}
                                    ${entry.getSurname()}</option>
                        </c:if>
                    </c:forEach>
                </optgroup>
                <optgroup label="Therapist">
                    <c:forEach items="${doctors}" var="entry">
                        <c:if test="${entry.getDepartment() == 'Therapist' }">
                            <option class="tablinks"
                                    onclick="openCity(event, '${entry.getLogin()}')">${entry.getName()}
                                    ${entry.getSurname()}</option>
                        </c:if>
                    </c:forEach>
                </optgroup>
                <optgroup label="Traumatologist">
                    <c:forEach items="${doctors}" var="entry">
                        <c:if test="${entry.getDepartment() == 'Traumatologist' }">
                            <option class="tablinks"
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
            <p><select size="15" multiple>
                <c:forEach items="${doctors}" var="entry">
                    <option class="tablinks"
                            onclick="openCity(event, '${entry.getLogin()}')">${entry.getName()}
                            ${entry.getSurname()}</option>
                </c:forEach>
            </select></p>
        </div>
    </c:if>
    <c:forEach items="${doctors}" var="entry">
        <div id="${entry.getLogin()}" class="tabcontent" hidden>
            <p class="login">Login : ${entry.getLogin()}</p>
            <p>Passport : ${entry.getPassport()}</p>
            <p>Name : ${entry.getName()}</p>
            <p>Surname : ${entry.getSurname()}</p>
            <p>Phone : ${entry.getTelephone()}</p>
            <p>Department : ${entry.getDepartment()}</p>
        </div>
    </c:forEach>
    <br>
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
        <form action="/controller" method="post">
            <input name="command" value="deleteDoctor" hidden>
            <p><select size="2" name="select">
                <c:forEach items="${doctors}" var="entry">
                    <option value="${entry.getId()}">${entry.getName()}
                            ${entry.getSurname()}</option>
                </c:forEach>
            </select></p>
            <input type="submit" value="Удалить">
        </form>
    </div>
</div>

<div id="right">
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
            <p>Name : ${entry.getName()}</p>
            <p>Surname : ${entry.getSurname()}</p>
            <p>Phone : ${entry.getTelephone()}</p>
        </div>
    </c:forEach>
</div>
</body>
</html>