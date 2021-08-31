<%@ page import="com.ua.entity.Doctor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
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
        * {
            box-sizing: border-box
        }

        body {
            font-family: "Lato", sans-serif;
        }

        /* Style the tab */
        .tab {
            float: left;
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
            float: left;
        }

        .tabcontent p.login {
            opacity: 50%;
        }

    </style>
</head>
<body>
<div class="tab">
        <p><select size="12" multiple>
            <optgroup label="Pediatric">
                <c:forEach items="${doctorsByName}" var="entry">
                    <c:if test="${entry.getDepartment() == 'Pediatric' }">
                        <option class="tablinks"
                                onclick="openCity(event, '${entry.getLogin()}')">${entry.getName()}
                                ${entry.getSurname()}</option>
                    </c:if>
                </c:forEach>
            </optgroup>
            <optgroup label="Surgeon">
                <c:forEach items="${doctorsByName}" var="entry">
                    <c:if test="${entry.getDepartment() == 'Surgeon' }">
                        <option class="tablinks"
                                onclick="openCity(event, '${entry.getLogin()}')">${entry.getName()}
                                ${entry.getSurname()}</option>
                    </c:if>
                </c:forEach>
            </optgroup>
            <optgroup label="Therapist">
                <c:forEach items="${doctorsByName}" var="entry">
                    <c:if test="${entry.getDepartment() == 'Therapist' }">
                        <option class="tablinks"
                                onclick="openCity(event, '${entry.getLogin()}')">${entry.getName()}
                                ${entry.getSurname()}</option>
                    </c:if>
                </c:forEach>
            </optgroup>
            <optgroup label="Traumatologist">
                <c:forEach items="${doctorsByName}" var="entry">
                    <c:if test="${entry.getDepartment() == 'Traumatologist' }">
                        <option class="tablinks"
                                onclick="openCity(event, '${entry.getLogin()}')">${entry.getName()}
                                ${entry.getSurname()}</option>
                    </c:if>
                </c:forEach>
            </optgroup>
        </select></p>
</div>
<c:forEach items="${doctorsByName}" var="entry">
    <div id="${entry.getLogin()}" class="tabcontent" hidden>
        <p class="login">Login : ${entry.getLogin()}</p>
        <p>Passport : ${entry.getPassport()}</p>
        <p>Name : ${entry.getName()}</p>
        <p>Surname : ${entry.getSurname()}</p>
        <p>Phone : ${entry.getTelephone()}</p>
        <p>Department : ${entry.getDepartment()}</p>
    </div>
</c:forEach>
</body>
</html>