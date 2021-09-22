<%@ page import="com.ua.entity.Doctor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="loc" uri="http://com.ua/FinalProject" %>

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

            var acc = document.getElementsByClassName("accordion");
            var i;

            for (i = 0; i < acc.length; i++) {
                acc[i].addEventListener("click", function () {
                    this.classList.toggle("active");
                    var panel = this.nextElementSibling;
                    if (panel.style.maxHeight) {
                        panel.style.maxHeight = null;
                    } else {
                        panel.style.maxHeight = panel.scrollHeight + "px";
                    }
                });
            }
        }
    </script>
    <style>
        @import url(/users/css/highBanner.css);
        @import url(/users/css/doctorList_center.css);
        @import url(/users/css/table_case_record.css);

        .rounded {
            counter-reset: li;
            list-style: none;
            font: 17px "Trebuchet MS", "Lucida Sans";
            padding: 0;
            text-shadow: 0 1px 0 rgba(255, 255, 255, 0.5);
        }

        .rounded a {
            position: relative;
            display: block;
            padding: .4em .4em .4em 2em;
            margin: .5em 25px;
            background: #DAD2CA;
            color: #444;
            text-decoration: none;
            border-radius: .3em;
            transition: .3s ease-out;
        }

        .rounded a#font {
            position: relative;
            display: block;
            padding: .4em .4em .4em 2em;
            margin: .5em 25px .5em 50px;
            background: #DAD2CA;
            color: #444;
            text-decoration: none;
            border-radius: .3em;
            transition: .3s ease-out;
        }

        .rounded a:hover {
            background: #e9e4e0;
        }

        .rounded b {
            position: relative;
            display: block;
            padding: .4em .4em .4em 2em;
            margin: .5em 25px;
            background: #DAD2CA;
            color: #444444;
            text-transform: uppercase;
            text-decoration: none;
            border-radius: .3em;
            transition: .3s ease-out;
        }

        .rounded b:hover {
            background: #E9E4E0;
        }

        .rounded b:before {
            content: "";
            /*content: counter(li);*/
            /*counter-increment: li;*/
            position: absolute;
            left: -1.3em;
            top: 50%;
            margin-top: -1.3em;
            background: #8FD4C1;
            height: 2em;
            width: 2em;
            line-height: 2em;
            border: .3em solid white;
            text-align: center;
            font-weight: bold;
            border-radius: 2em;
            transition: all .3s ease-out;
        }

        .rounded a:hover:before {
            transform: rotate(360deg);
        }

        .rounded a:before {
            content: counter(li);
            counter-increment: li;
            position: absolute;
            left: -1.3em;
            top: 50%;
            margin-top: -1.3em;
            background: #8FD4C1;
            height: 2em;
            width: 2em;
            line-height: 2em;
            border: .3em solid white;
            text-align: center;
            font-weight: bold;
            border-radius: 2em;
            transition: all .3s ease-out;
        }

    </style>
</head>
<body>
<ul id="nav">
    <li class="right"><p class="tablinks2" onclick="openCity2(event, 'Staff')" id="defaultOpen">
        <loc:print key="Head_Button_Doctor"/></p></li>
    <li class="right"><p class="tablinks2" onclick="openCity2(event, 'Nurse')">
        <loc:print key="Head_Button_Nurse"/></p></li>
    <li class="right"><p class="tablinks2" onclick="openCity2(event, 'Patient')">
        <loc:print key="Head_Button_Patient"/></p></li>
    <li class="right"><p class="tablinks2" onclick="openCity2(event, 'Archive')">
        <loc:print key="Head_Button_Archive"/></p></li>


    <li class="left"><p><a href="/controller?command=exit">
        <loc:print key="Head_Button_Exit"/></a></p></li>
    <c:forTokens items="${initParam['locales']}"
                 var="locale" delims=" ">
        <li class="left">
            <p><a href="/changeLocale.jsp?localeToSet=${locale}&pageToForward=users/doctorList.jsp&basename=message_${locale}">
                <img src="${locale}.png" width="20" height="20"></a></p>
        </li>
    </c:forTokens>
    <li class="left"><p>
        <loc:print key="Head_Button_Login"/>${globalLogin}</p></li>
    <li class="left"><p><a href="/controller?command=viewStaff">
        <loc:print key="Head_Button_Refresh"/></a></p></li>
</ul>

<div id="Staff" class="tabcontent2">
    <form action="/controller" method="post">
        <c:if test="${check == 'on'}">
            <div class="tab">
                <ol class="rounded">
                    <c:forEach items="${departments}" var="department">
                        <li><b>${department.description}</b>
                            <ol class="rounded">
                                <c:forEach items="${doctors}" var="patient">
                                    <c:if test="${patient.getDepartment() == department.description }">
                                        <li><a href="#" class="tablinks" id="font"
                                               onclick="openCity(event, '${patient.getLogin()}')"> ${patient.getName()}
                                                ${patient.getSurname()}</a></li>
                                    </c:if>
                                </c:forEach>
                            </ol>
                        </li>
                    </c:forEach>
                </ol>
            </div>
        </c:if>
        <c:if test="${check != 'on'}">
            <div class="tab">
                <ol class="rounded">
                    <c:forEach items="${doctors}" var="patient">
                        <li><a href="#" class="tablinks"
                               onclick="openCity(event, '${patient.getLogin()}')"> ${patient.getName()}
                                ${patient.getSurname()}</a></li>
                    </c:forEach>
                </ol>
            </div>
        </c:if>
        <c:forEach items="${doctors}" var="patient">
            <div id="${patient.getLogin()}" class="tabcontent" hidden>
                <output>
                    <i><p class="login">${patient.getLogin()}</p>
                        <p>${patient.getPassport()}</p>
                        <p>${patient.getName()}</p>
                        <p>${patient.getSurname()}</p>
                        <p>${patient.getTelephone()}</p>
                        <p>${patient.getDepartment()}</p>
                        <p></p>
                        <c:forEach items="${patient.getCaseRecords()}" var="card">
                            <p>${card.getPatient().getName()} ${card.getPatient().getSurname()}(${card.getInitialDiagnosis()})</p>
                        </c:forEach>
                    </i>
<%--                    <i><p class="login"><loc:print key="Login_Anketa"/>${patient.getLogin()}</p>--%>
<%--                        <p><loc:print key="Passport_Anketa"/>${patient.getPassport()}</p>--%>
<%--                        <p><loc:print key="Name_Anketa"/>${patient.getName()}</p>--%>
<%--                        <p><loc:print key="Surname_Anketa"/>${patient.getSurname()}</p>--%>
<%--                        <p><loc:print key="Telephone_Anketa"/>${patient.getTelephone()}</p>--%>
<%--                        <p><loc:print key="Department_Anketa"/>${patient.getDepartment()}</p>--%>
<%--                        <p><loc:print key="Patient_case_Anketa"/></p>--%>
<%--                        <c:forEach items="${patient.getCaseRecords()}" var="card">--%>
<%--                            <p>${card.getPatient().getName()} ${card.getPatient().getSurname()}(${card.getInitialDiagnosis()})</p>--%>
<%--                        </c:forEach>--%>
<%--                    </i>--%>
                </output>
            </div>
        </c:forEach>
        <div class="button">
            <table>
                <tr>
                    <td>
                        <button type="submit" name="command" value="deleteDoctor" width="100%">
                            <loc:print key="Delete_Employee"/>
                        </button>
                    </td>
                    <td>
                        <button type="submit" name="command" value="redirect" width="100%">
                            <loc:print key="Add_Employee"/>
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
                <label><input type="checkbox" name="check" value="on">
                    <loc:print key="Categorize_By"/></label><br>
            </c:if>
            <c:if test="${check=='on'}">
                <label><input type="checkbox" name="check" value="on" checked>
                    <loc:print key="Categorize_By"/></label><br>
            </c:if>
            <c:if test="${sort=='sortByName'|| sort==null}">
                <label><input type="radio" name="sort" value="sortByName" checked>
                    <loc:print key="Sorted_By_Name"/></label><br>
                <label><input type="radio" name="sort" value="sortByCount">
                    <loc:print key="Sorted_By_Patients"/></label><br></label><br>
            </c:if>
            <c:if test="${sort=='sortByCount'}">
                <label><input type="radio" name="sort" value="sortByName">
                    <loc:print key="Sorted_By_Name"/></label><br></label><br>
                <label><input type="radio" name="sort" value="sortByCount" checked>
                    <loc:print key="Sorted_By_Patients"/></label><br>
            </c:if>
            <input type="submit" value="<loc:print key="Sorted"/>">
            <input name="command" value="sortDoctorList" hidden>
        </form>
        </p>
    </div>
</div>

<%--<div id="Nurse" class="tabcontent2">--%>
<%--    <div class="tab">--%>
<%--        <ol class="rounded">--%>
<%--            <c:forEach items="${nurses}" var="patient">--%>
<%--                <li>--%>
<%--                    <a href="#" class="tablinks"--%>
<%--                       onclick="openCity(event, '${patient.getLogin()}')"> ${patient.getName()}--%>
<%--                            ${patient.getSurname()}</a>--%>
<%--                </li>--%>
<%--            </c:forEach>--%>
<%--        </ol>--%>
<%--    </div>--%>
<%--    <c:forEach items="${nurses}" var="patient">--%>
<%--        <div id="${patient.getLogin()}" class="tabcontent" hidden>--%>
<%--            <output>--%>
<%--                <i><p class="login"><loc:print key="Login_Anketa"/>${patient.getLogin()}</p>--%>
<%--                    <p><loc:print key="Passport_Anketa"/>${patient.getPassport()}</p>--%>
<%--                    <p><loc:print key="Name_Anketa"/>${patient.getName()}</p>--%>
<%--                    <p><loc:print key="Surname_Anketa"/>${patient.getSurname()}</p>--%>
<%--                    <p><loc:print key="Telephone_Anketa"/>${patient.getTelephone()}</p>--%>
<%--                </i>--%>
<%--            </output>--%>
<%--        </div>--%>
<%--    </c:forEach>--%>
<%--</div>--%>

<%--<div id="Patient" class="tabcontent2">--%>
<%--    <div class="tab">--%>
<%--        <ol class="rounded">--%>
<%--            <c:forEach items="${patients}" var="patient">--%>
<%--                <li>--%>
<%--                    <a href="#" class="tablinks"--%>
<%--                       onclick="openCity(event, '${patient.getId()}')"> ${patient.getName()}--%>
<%--                            ${patient.getSurname()}</a>--%>
<%--                </li>--%>
<%--            </c:forEach>--%>
<%--        </ol>--%>
<%--    </div>--%>

<%--    <c:forEach items="${patients}" var="patient">--%>
<%--        <div id="${patient.getId()}" class="tabcontent" hidden>--%>
<%--            <p><loc:print key="Passport_Anketa"/>${patient.getPassport()}</p>--%>
<%--            <p><loc:print key="Birthday_Anketa"/>--%>
<%--                : ${patient.getDayBorn()}-${patient.getMonthBorn()}-${patient.getYearBorn()}(${patient.getYears()})</p>--%>
<%--            <p><loc:print key="Name_Anketa"/>${patient.getName()}</p>--%>
<%--            <p><loc:print key="Surname_Anketa"/>${patient.getSurname()}</p>--%>
<%--            <p><loc:print key="Telephone_Anketa"/>${patient.getTelephone()}</p>--%>
<%--            <c:forEach items="${patient.getCaseRecords()}" var="card">--%>
<%--                <p class="MyMarginLeft"><loc:print key="Diagnosis_Anketa"/>(${card.getInitialDiagnosis()})--%>
<%--                    <loc:print key="Attending_Physician_Anketa"/>--%>
<%--                    <c:if test="${card.getDoctor().getName() != null}">--%>
<%--                        ${card.getDoctor().getName()} ${card.getDoctor().getSurname()}--%>
<%--                    </c:if>--%>
<%--                    <c:if test="${card.getDoctor().getName() == null}">--%>
<%--                        <loc:print key="Not_Available"/>--%>
<%--                    </c:if>--%>
<%--                </p>--%>
<%--            </c:forEach>--%>
<%--        </div>--%>
<%--    </c:forEach>--%>
<%--    <form class="button" action="/controller" method="get">--%>
<%--        <input name="command" value="addNewPatient" hidden>--%>
<%--        <p align="left"><input type="submit" value="<loc:print key="Add_Patient"/>"></p>--%>
<%--    </form>--%>
<%--    <div class="button">--%>
<%--        <p align="left">--%>
<%--        <form>--%>
<%--            <input name="command" value="sortPatientList" hidden>--%>
<%--            <c:if test="${sort2=='sortByName'|| sort2==null}">--%>
<%--                <label><input type="radio" name="sort2" value="sortByName" checked>--%>
<%--                    <loc:print key="Sorted_By_Name"/></label><br>--%>
<%--                <label><input type="radio" name="sort2" value="sortByBirthday">--%>
<%--                    <loc:print key="Sorted_By_Age"/></label><br>--%>
<%--            </c:if>--%>
<%--            <c:if test="${sort2=='sortByBirthday'}">--%>
<%--                <label><input type="radio" name="sort2" value="sortByName">--%>
<%--                    <loc:print key="Sorted_By_Name"/></label><br>--%>
<%--                <label><input type="radio" name="sort2" value="sortByBirthday" checked>--%>
<%--                    <loc:print key="Sorted_By_Age"/></label><br>--%>
<%--            </c:if>--%>
<%--            <input type="submit" value="<loc:print key="Sorted"/>">--%>
<%--        </form>--%>
<%--        <form class="button" action="/controller" method="post">--%>
<%--            <p>Назначить врача пациенту</p>--%>
<%--            <input name="command" value="doctorToPatient" hidden>--%>
<%--            <p><select name="selectDoctor">--%>
<%--                <c:forEach items="${doctors}" var="patient">--%>
<%--                    <option value="${patient.getId()}">${patient.getName()}--%>
<%--                            ${patient.getSurname()} - ${patient.getDepartment()}</option>--%>
<%--                </c:forEach>--%>
<%--            </select>--%>
<%--                <select name="selectPatient">--%>
<%--                    <c:forEach items="${patients}" var="patient">--%>
<%--                        <c:forEach items="${patient.getCaseRecords()}" var="diagnose">--%>
<%--                            <c:if test="${diagnose.getDoctor().getName()==null}">--%>
<%--                                <option value="${diagnose.getId()}">${patient.getName()}--%>
<%--                                        ${patient.getSurname()} - ${diagnose.getInitialDiagnosis()}</option>--%>
<%--                            </c:if>--%>
<%--                        </c:forEach>--%>
<%--                    </c:forEach>--%>
<%--                </select></p>--%>
<%--            <input type="submit" value="<loc:print key="Assigment"/>">--%>
<%--        </form>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<div id="Archive" class="tabcontent2">--%>
<%--    <table align="center">--%>
<%--        <tr class="table1">--%>
<%--            <th class="table1" width="5%">id</th>--%>
<%--            <th class="table1" width="15%"><loc:print key="Passport_Anketa"/></th>--%>
<%--            <th class="table1" width="20%"><loc:print key="Patient_Anketa"/></th>--%>
<%--            <th class="table1" width="23%"><loc:print key="Provisional_Diagnosis"/></th>--%>
<%--            <th class="table1" width="22%"><loc:print key="Final_Diagnosis"/></th>--%>
<%--            <th class="table1"><loc:print key="Medical_Appointments"/></th>--%>
<%--        </tr>--%>
<%--        <c:forEach items="${archivePatient}" var="patient">--%>
<%--            <c:if test="${patient.getCaseRecords().size() != 0}">--%>
<%--                <c:forEach items="${patient.getCaseRecords()}" var="cr" varStatus="i">--%>
<%--                    <tr class="table1">--%>
<%--                        <td class="table1">${i.count}</td>--%>
<%--                        <td class="table1">${patient.getPassport()}</td>--%>
<%--                        <td class="table1">${patient.getName()} ${patient.getSurname()}</td>--%>
<%--                        <td class="table1">${cr.getInitialDiagnosis()}</td>--%>
<%--                        <td class="table1">${cr.getFinalDiagnosis()}</td>--%>
<%--                        <td class="table1"><a href="/controller?command=archiveAppointment&appointmentId=${cr.getId()}">Подробно</a>--%>
<%--                        </td>--%>
<%--                    </tr>--%>
<%--                </c:forEach>--%>
<%--            </c:if>--%>
<%--        </c:forEach>--%>
<%--    </table>--%>
<%--</div>--%>

<script>
    // Get the element with id="defaultOpen" and click on it
    document.getElementById("defaultOpen").click();
</script>
</body>
</html>